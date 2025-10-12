import os.path

import pandas as pd

from tools.python.lib.FileIO import FileIO
from tools.python.lib.xml import XML
from tools.python.lib.binary_extracted import text_to_bytes, bytes_to_text
from io import BytesIO
from pathlib import Path
from typing import Union
import lxml.etree as etree
import struct

class Stage(FileIO):

    def __init__(self, path: Union[Path, str, BytesIO, bytes], mode="r+b", endian="little"):
        super().__init__(path, mode, endian)
        super().__enter__()
        self.base_address = 0x756700 - 0x10
        self.start = 0x90
        self.size = os.path.getsize(path)
        self.blocks_reference = []
        self.sections_start = []
        self.speakers = {}
        self.speaker_id = 1


    #Extract blocks at 0x90
    def extract_blocks_reference(self):
        self.seek(self.start)
        nb_blocks = 3
        for _ in range(nb_blocks):

            start =  int((hex(self.read_int16()) + '000000')[0:8].replace('0x', ''), 16)
            self.read(6)
            offset = self.read_int16()
            #print(f'Block Mem: {hex(start + offset)}')
            final = start + offset - self.base_address

            self.read(6)

            if (final > 0):
                self.blocks_reference.append(final)

    def extract_all_blocks(self):
        self.extract_blocks_reference()
        res = []

        story_text = ''
        block_id = 1
        self.blocks_reference = self.blocks_reference[1:]
        for block_reference in self.blocks_reference:
            #block_reference = self.blocks_reference[1]
            self.seek(block_reference)
            value = self.read_uint32()
            sections_count = self.read_uint32()
            #print(f'Block start: {hex(value - self.base_address)} - Sections count: {sections_count}')

            if (value - self.base_address) > 0:

                self.seek(value - self.base_address)

                #Direct String
                if sections_count == 0:
                    speaker_text, text = self.extract_string()
                    self.add_speaker(speaker_text, '')

                    res.append((speaker_text, text, -1, hex(block_reference)))
                    story_text += f'Speaker: {speaker_text}\n{text}\n\n'

                #Section
                else:

                    section_id = 1
                    for i in range(sections_count):
                        #print(f'Pointer: {hex(self.tell())}')
                        section_start = self.read_uint32() - self.base_address
                        pos = self.tell()
                        if section_start > 0 and section_start < self.size:
                            #print(f'Section Start: {hex(section_start + 0x20)}')
                            section_text = self.extract_section_text(section_start + 0x20)
                            #text = '\n\n'.join([f'Speaker: {speaker}\n{text}' for speaker,text in section_text])

                            ele = {
                                "Section": f'Section {block_id}.{section_id}',
                                "Text": section_text
                            }
                            res.append(ele)
                            section_id += 1

                        self.seek(pos + 4)


            block_id += 1
        return res

    def extract_sections_offset(self, start:int):
        self.seek(start)

    def extract_string(self):
        speaker_text, bytes1 = bytes_to_text(self, self.tell(), True)
        text, text_bytes = bytes_to_text(self)

        #If text is empty then there's no speaker
        if text == '':
            text = speaker_text
            speaker_text = ''

        return speaker_text, text

    def extract_section_text(self, start:int):

        pos = start
        res = []

        while True:
            self.seek(pos)
            struct_value = self.read_uint32()


            if struct_value >= 0x60: break

            self.seek(self.tell() + 12)
            pointer_offset = self.tell()
            pointer_value = self.read_uint32()

            if pointer_value > self.base_address:
                offset = pointer_value - self.base_address
                self.seek(offset)

                speaker_text, text = self.extract_string()
                self.add_speaker(speaker_text, '')
                #print(f'Speaker: {hex(offset)} - {speaker_text}')
                #print(f'Offset: {hex(offset)} - {text}')

                res.append((speaker_text, text, pointer_offset))
            pos = pos + 32

        return res

    def extract_sections_start(self, block_start:int, block_reference:int):
        self.seek(block_start)
        while self.tell() < block_reference:
            val = self.read_uint32()

            if val > self.base_address:
                start = val - self.base_address

                unknown_number = self.read_uint32()
                val = self.read_at(start,1)

                if val == b'\x4B':
                    self.sections_start.append(start)

    def extract_sections_text(self, path:Path):

        for i, section_start in enumerate(self.sections_start):

            if i == len(self.sections_start)-1:
                max = 0
            else:
                max = self.sections_start[i+1]

            self.extract_section_text(section_start+0x20, max)



    def add_speaker(self, speaker_text:str, pointer_offset:int):

        if speaker_text not in self.speakers.keys():
            self.speakers[speaker_text] = {
                "PointerOffset": pointer_offset,
                "Id": self.speaker_id
            }

            self.speaker_id += 1

    def extract_stage_XML(self, xml_path:Path):

        root = etree.Element("ScenarioText")
        res = self.extract_all_blocks()

        #Add Speakers Nodes
        speakers_node = etree.SubElement(root, 'Speakers')
        etree.SubElement(speakers_node, "Section").text = 'Speaker'
        for speaker_text, node in self.speakers.items():
            XML.create_node(speakers_node, speaker_text, node['PointerOffset'], id=node['Id'], speaker_id=-1)

        #Add Sections Nodes
        for node in res:
            strings_node = etree.SubElement(root, 'Strings')
            etree.SubElement(strings_node, "Section").text = node['Section']

            for speaker, text, pointer_offset in node['Text']:
                speaker_node = self.speakers[speaker]
                XML.create_node(strings_node, text, pointer_offset,
                                id=-1, speaker_id=speaker_node['Id'])

        if len(res) > 0:
            with open(xml_path, "wb") as xmlFile:
                xmlFile.write(etree.tostring(root, encoding="UTF-8", pretty_print=True))


