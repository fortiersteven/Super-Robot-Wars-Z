import os.path

import pandas as pd

from tools.python.lib.FileIO import FileIO
from tools.python.lib.binary_extracted import text_to_bytes, bytes_to_text
from io import BytesIO
from pathlib import Path
from typing import Union
import struct
import lxml.etree as etree


class XML():


    @staticmethod
    def create_node(strings_node, jap_text:str, pointer_offset:int, id=-1, speaker_id=-1):
        entry_node = etree.SubElement(strings_node, "Entry")

        if pointer_offset != '':
            etree.SubElement(entry_node, "PointerOffset").text = str(pointer_offset).replace(", ", ",")

        etree.SubElement(entry_node, "JapaneseText").text = jap_text
        etree.SubElement(entry_node, "EnglishText")
        etree.SubElement(entry_node, "Notes")

        if jap_text == '':
            status_text = 'Done'
        else:
            status_text = 'To Do'

        if id > -1:
            etree.SubElement(entry_node, "Id").text = str(id)

        if speaker_id > -1:
            etree.SubElement(entry_node, "SpeakerId").text = str(speaker_id)
        etree.SubElement(entry_node, "Chapter").text = "Uncategorized"
        etree.SubElement(entry_node, "Status").text = status_text


