import os.path

import pandas as pd

from tools.python.lib.FileIO import FileIO
from tools.python.lib.binary_extracted import text_to_bytes, bytes_to_text
from io import BytesIO
from pathlib import Path
from typing import Union
import struct

class Library(FileIO):

    def __init__(self, path: Union[Path, str, BytesIO, bytes], mode="r+b", endian="little"):
        super().__init__(path, mode, endian)
        super().__enter__()
        self.start = 0x449070
        self.base_address = 0x756700 - 0x10
        self.start = 0x90
        self.size = os.path.getsize(path)
        self.blocks_reference = []
        self.sections_start = []


    def extract_entires(self):

