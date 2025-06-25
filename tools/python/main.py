import argparse
from pathlib import Path
from lib.SRWZ import SRWZ


def get_arguments(argv=None):
    # Init argument parser
    parser = argparse.ArgumentParser()

    parser.add_argument(
        "-p",
        "--project",
        required=True,
        type=Path,
        metavar="project",
        help="project.json file path",
    )

    sp = parser.add_subparsers(title="Available actions", required=False, dest="action")

    # Extract commands
    sp_extract = sp.add_parser(
        "extract",
        description="Extract the content of the files",
        help="Extract the content of the files",
        formatter_class=argparse.RawTextHelpFormatter,
    )

    sp_extract.add_argument(
        "-ft",
        "--file_type",
        choices=["Iso", "Main", "Menu", "Story", "Skits"],
        required=True,
        metavar="file_type",
        help="(Required) - Options: Iso, Init, Main, Menu, Story, Skits",
    )

    sp_extract.add_argument(
        "-i",
        "--iso",
        required=False,
        default="../b-topndxj.iso",
        metavar="iso",
        help="(Optional) - Only for extract Iso command",
    )

    sp_extract.add_argument(
        "-r",
        "--replace",
        required=False,
        metavar="replace",
        default=False,
        help="(Optional) - Boolean to uses translations from the Repo to overwrite the one in the Data folder",
    )

    sp_extract.add_argument(
        "--only-changed",
        required=False,
        action="store_true",
        help="(Optional) - Insert only changed files not yet commited",
    )

    sp_insert = sp.add_parser(
        "insert",
        help="Take the new texts and recreate the files",
    )

    sp_insert.add_argument(
        "-ft",
        "--file_type",
        choices=["Iso", "Main", "Menu", "Story", "Skits", "All", "Asm"],
        required=True,
        metavar="file_type",
        help="(Required) - Options: Iso, Init, Main, Elf, Story, Skits, All, Asm",
    )

    sp_insert.add_argument(
        "-i",
        "--iso",
        required=False,
        default="",
        type=Path,
        metavar="iso",
        help="(Deprecated) - No longer in use for insertion",
    )

    sp_insert.add_argument(
        "--with-proofreading",
        required=False,
        action="store_const",
        const="Proofreading",
        default="",
        help="(Optional) - Insert lines in 'Proofreading' status",
    )

    sp_insert.add_argument(
        "--with-editing",
        required=False,
        action="store_const",
        const="Editing",
        default="",
        help="(Optional) - Insert lines in 'Editing' status",
    )

    sp_insert.add_argument(
        "--with-problematic",
        required=False,
        action="store_const",
        const="Problematic",
        default="",
        help="(Optional) - Insert lines in 'Problematic' status",
    )

    sp_insert.add_argument(
        "--only-changed",
        required=False,
        action="store_true",
        help="(Optional) - Insert only changed files not yet commited",
    )

    args = parser.parse_args()

    return args



if __name__ == "__main__":

    args = get_arguments()

    insert_mask = ['Proofreading', 'Editing']
    robotwars = SRWZ(args.project.resolve(), insert_mask, args.only_changed)
    if args.action == "extract":

        if args.file_type == "Iso":
            robotwars.extract_iso(game_iso=args.iso)

        elif args.file_type == "Menu":
            robotwars.extract_all_menus()

    elif args.action =="insert":

        if args.file_type == "Menu":
            robotwars.pack_all_menu()
            robotwars.patch_binaries()
            #robotwars.make_iso()
