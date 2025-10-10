import re
import struct
import pyjson5 as json
import string
from tools.python.lib.FileIO import FileIO

VALID_VOICEID = [r'(VSM_\w+)', r'(VCT_\w+)', r'(S\d+)', r'(C\d+)']
COMMON_TAG = r"(<[\w/]+:?\w+>)"
HEX_TAG = r"(\{[0-9A-F]{2}\})"
PRINTABLE_CHARS = "".join(
            (string.digits, string.ascii_letters, string.punctuation, " ")
        )
jsonTblTags = dict()
with open('project/tbl_all.json') as f:
    jsonraw = json.loads(f.read(), encoding="utf-8")
    for k, v in jsonraw.items():
        jsonTblTags[k] = {int(k2, 16): v2 for k2, v2 in v.items()}

ijsonTblTags = dict()
for k, v in jsonTblTags.items():
    if k in ['tags', 'tbl']:
        ijsonTblTags[k] = {v2: k2 for k2, v2 in v.items()}
    else:
        ijsonTblTags[k] = {v2: hex(k2).replace('0x', '').upper() for k2, v2 in v.items()}
iTags = {v2.upper(): k2 for k2, v2 in jsonTblTags['tags'].items()}


def bytes_to_text(src: FileIO, offset: int = -1, speaker:bool = False):
    finalText = ""
    chars = jsonTblTags['tbl']

    if (offset > 0):
        src.seek(offset, 0)
    buffer = b''
    while True:
        b = src.read(1)

        if b == b"\x00": break

        buffer += b
        b = ord(b)

        # Tags
        if b in [0x31, 0x32, 0x33, 0x34, 0x35]:

            if b in jsonTblTags['tags'].keys():
                tag_name = jsonTblTags['tags'].get(b)
            else:
                tag_name = hex(b).upper().replace('0X','')

            value = src.read(1).hex().upper()
            finalText += f"<{tag_name}:{value}>"
            continue

        # Custom Encoded Text
        if (0x80 <= b <= 0x9F) or (0xE0 <= b <= 0xEA):
            c = (b << 8) | src.read_uint8()
            finalText += chars.get(c, "{%02X}{%02X}" % (c >> 8, c & 0xFF))
            continue

        if b == 0x0A:

            if speaker:
                return finalText, buffer

            finalText += ("\n")
            continue

        # ASCII text
        if chr(b) in PRINTABLE_CHARS:
            finalText += chr(b)
            continue

        # cp932 text
        if 0xA0 < b < 0xE0:
            finalText += struct.pack("B", b).decode("cp932")
            continue



        finalText += "{%02X}" % b

    return finalText, buffer


def get_shift_equivalent(character:str):
    base = 33311
    b = ord(character.encode('cp932'))

    if character.isupper():
        return (b + base).to_bytes(2, 'big')

    else:
        return (b + base + 1).to_bytes(2, 'big')



def text_to_bytes(text:str, font_adjusted:bool):
    multi_regex = (HEX_TAG + "|" + COMMON_TAG + r"|(\n)")
    tokens = [sh for sh in re.split(multi_regex, text) if sh]
    output = b''
    percent_found = False

    dict_spec = {
        "≥": b'\x3F\x18'
    }
    list_weird = []

    for t in tokens:
        # Hex literals
        if re.match(HEX_TAG, t):
            output += struct.pack("B", int(t[1:3], 16))

        # Control codes with the format of <XX> or <XX:XX>
        elif re.match(COMMON_TAG, t):
            tag, param, *_ = t[1:-1].split(":") + [None]

            #Known control codes
            if tag in ['width', 'color', 'space', 'height']:
                tag_int = ijsonTblTags['tags'][tag]
            else:
                tag_int = int(tag, 16)

            output += bytes([tag_int])
            output += bytes([int(param,16)])

        # Line Break
        elif t == "\n":
            output += b"\x0A"

        else:
            for c in t:

                #Special Characters not in ASCII
                if c in dict_spec.keys():
                    output += dict_spec[c]

                #ASCII characters
                elif c in PRINTABLE_CHARS:

                    val = b''
                    if c >= '.' and c <= '?' and c != '%':

                        #Skip if % sign to see if we don't find %s
                        #%s is handled differently with the game and we dont want to add 0x3F
                        if c == '%':
                            percent_found = True

                        else:
                            val += b'\x3F'
                            val += c.encode("cp932")

                    elif percent_found:

                        #If we dont have a %s pattern, we add our 0x3F special control code
                        if c != 's':
                            val += b'\x3F'

                        val += c.encode("cp932")

                    else:
                        val += c.encode("cp932")



                    if not font_adjusted:
                        val = get_shift_equivalent(c)

                    output += val

                #Shift-Jis
                else:

                    if c in ijsonTblTags["tbl"].keys():
                        b = ijsonTblTags["tbl"][c].to_bytes(2, 'big')
                        output += b
                    else:
                        c = c.replace("\u200b", "")
                        output += c.encode("cp932")

    return output