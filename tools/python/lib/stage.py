import os.path

import pandas as pd

from tools.python.lib.FileIO import FileIO
from tools.python.lib.xml import XML
from tools.python.lib.binary_extracted import text_to_bytes, bytes_to_text
from io import BytesIO
from pathlib import Path
from typing import Union
import lxml.etree as etree
import re
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

    def extract_stage_XML(self, original_path:Path, translated_path:Path, keep_translations:bool=True):

        root = etree.Element("ScenarioText")
        res = self.extract_all_blocks()

        #Add Speakers Nodes
        speakers_node = etree.SubElement(root, 'Speakers')
        etree.SubElement(speakers_node, "Section").text = 'Speaker'
        for speaker_text, node in self.speakers.items():
            XML.create_node(speakers_node, speaker_text, node['PointerOffset'], id=node['Id'], speaker_id=-1)

        #Add Conditions
        for condition_label, value in self.conditions_data.items():
            strings_node = etree.SubElement(root, 'Strings')
            etree.SubElement(strings_node, "Section").text = condition_label

            for condition_entry in value:
                XML.create_node(strings_node, condition_entry['text'], condition_entry['pointer_offset'],
                                id=-1, speaker_id=-1)
        #Add Sections Nodes
        for node in res:
            strings_node = etree.SubElement(root, 'Strings')
            etree.SubElement(strings_node, "Section").text = node['Section']

            for speaker, text, pointer_offset in node['Text']:
                speaker_node = self.speakers[speaker]
                XML.create_node(strings_node, text, pointer_offset,
                                id=-1, speaker_id=speaker_node['Id'])


        if len(res) > 0:

            if keep_translations:
                self.copy_translations(root_original=root,
                                            translated_path=translated_path)

            with open(original_path, "wb") as xmlFile:
                xmlFile.write(etree.tostring(root, encoding="UTF-8", pretty_print=True))



    def find_conditions_pointers(self, func_offset:int):

        patterns = {'b05222ac':'_Victory Conditions', 'b85222ac':'_Defeat Condtions', 'c05222ac':'SR Conditions'}
        print(hex(func_offset))
        start = func_offset - self.base_address
        data = self.read_at(start, 200)
        res = {}
        for pattern, condition in patterns.items():
            pattern = re.compile(bytes.fromhex(pattern))
            curpos = 0

            pos = 0

            while True:
                m = pattern.search(data[curpos:])  # search next occurence
                if m is None: break  # no more could be found: exit loop

                pos = curpos + m.start() + start
                curpos += m.end()

                #conditions lo/hi
                self.seek(pos - 3*4)
                lo = self.tell()
                print(f'LO: {hex(lo + self.base_address)}')

                lo_value = self.read_uint16()
                self.read(2)

                hi_value = self.read_int16()
                table = (lo_value << 16) + hi_value
                print(f'{condition}: {hex(table)}')
                res[condition] = table

        return res

    def extract_conditions(self, func_offset:int):

        conditions = {}
        res = self.find_conditions_pointers(func_offset)

        for condition_label, base_pointer_offset in res.items():
            self.seek(base_pointer_offset - self.base_address)
            conditions[condition_label] = []
            pointer_offset = self.tell()

            for i in range(2):

                self.seek(pointer_offset)
                value = self.read_uint32()

                if value > 0:
                    offset = value - self.base_address
                    text, bytes_value = bytes_to_text(self, offset)
                    conditions[condition_label].append({"pointer_offset": pointer_offset, "text": text})
                    pointer_offset = pointer_offset + 4

        self.conditions_data = conditions


    def copy_translations(self, root_original, translated_path: Path):

        if translated_path.exists():

            original_entries = {entry_node.find('JapaneseText').text: (section.find('Section').text,) +
                                                                       self.parse_entry(entry_node) for section in
                                root_original.findall('Strings') for entry_node in section.findall('Entry')}

            tree = etree.parse(translated_path)
            root_translated = tree.getroot()
            translated_entries = {entry_node.find('JapaneseText').text:
                                      self.parse_entry(entry_node) for section in
                                  root_translated.xpath(".//Strings | .//Speakers") for entry_node in section.findall('Entry')}


            for entry_node in root_original.iter('Entry'):

                jap_text = entry_node.find('JapaneseText').text

                if jap_text in translated_entries:

                    translated = translated_entries[jap_text]

                    if translated[2] is not None:
                        entry_node.find('EnglishText').text = translated[1]
                        entry_node.find('Status').text = translated[3]
                        entry_node.find('Notes').text = translated[4]

                        node = entry_node.find('Chapter')
                        if node is not None:
                            entry_node.find('Chapter').text = translated[5] or 'Uncategorized'
                        else:
                            etree.SubElement(entry_node, "Chapter").text = translated[6] or 'Uncategorized'

            friendly_node = root_translated.find('FriendlyName')
            if friendly_node is not None:
                friendly = etree.Element("FriendlyName")
                friendly.text = friendly_node.text
                root_original.insert(0, friendly)


    def parse_entry(self, xml_node):

        jap_text = xml_node.find('JapaneseText').text
        eng_text = xml_node.find('EnglishText').text
        status = xml_node.find('Status').text
        notes = xml_node.find('Notes').text
        chapter_node = xml_node.find('Chapter')
        chapter = ''

        if chapter_node is not None:
            chapter = chapter_node.text

        final_text = eng_text or jap_text or ''
        return jap_text, eng_text, final_text, status, notes, chapter




