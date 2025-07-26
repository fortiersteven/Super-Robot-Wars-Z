import os.path
import shutil

import pandas as pd

from tools.python.lib.FileIO import FileIO
from tools.python.lib.binary_extracted import text_to_bytes, bytes_to_text
from io import BytesIO
from pathlib import Path
from typing import Union
import subprocess
import struct

class CompData(FileIO):

    def __init__(self, path: Union[Path, str, BytesIO, bytes], mode="r+b", endian="little"):
        super().__init__(path, mode, endian)
        super().__enter__()
        self.base_address = 0x756700 - 0x10
        self.start = 0x90
        self.size = os.path.getsize(path)
        self.blocks_reference = []
        self.sections_start = []
        self.json_file = 'DATA/COMPDATA/0d.bin'

    def pack_file(self, paths:dict, original_file:Path):

        #Compress
        env = os.environ.copy()
        python = paths['tools'] / 'python'
        env["PATH"] = f"{python.as_posix()};{env['PATH']}"
        dec = str(paths["temp_files"] / 'DATA' / 'COMPDATA' / '0d.bin')
        new = str(paths["final_files"] / 'New_files' / 'DATA' / 'COMPDATA.BN')
        orig = str(paths["temp_files"] / 'DATA' / 'COMPDATA' / 'COMPDATA.BN')
        r = subprocess.run(
            [
                paths['tools'] / 'python' / 'Compressor.exe',
                "-c",
                dec,
                new,
                original_file
            ],
            env=env
        )


