from pathlib import Path
from FileIO import FileIO
import os
def extract_archive(disc_path:Path, extract_path:Path):

    table_start = 0x32BEF0
    table_end = 0x32C203
    slps_path = disc_path / 'SLPS_258.87'
    mtv_path = disc_path / 'DATA' / 'MTV_BGC.BIN'
    mtv_size = os.path.getsize(mtv_path)
    offsets = []

    #Extract offsets from SLPS
    with FileIO(slps_path, 'rb') as f:
        f.seek(table_start)

        while (f.tell() < table_end):
            offset = f.read_uint32()
            offsets.append(offset)
        offsets.append(mtv_size)

    #Extract files from archive
    with FileIO(mtv_path, 'rb') as mtv:
        data = mtv.read()

        for i in range(len(offsets)-1):
            with open(extract_path / 'MTV_BGC' / f'{i}.bin', 'wb') as dest:
                dest.write(data[offsets[i]:offsets[i+1]])



disc_path = Path(r'G:\TalesHacking\Super Robot Taisen Z (Japan)\Super-Robot-Wars-Z\0_disc')
extracted_path = Path(r'G:\TalesHacking\Super Robot Taisen Z (Japan)\Super-Robot-Wars-Z\1_extracted')
extract_archive(disc_path, extracted_path)