#!/usr/bin/env python3

import os

# path where this script resides, rather than `os.getcwd()`
repo_path = os.path.dirname(os.path.realpath(__file__)) + "/"

items = {
        "vimrc"     : "~/.vimrc",
        "bashrc"    : "~/.bashrc"
        }


def get_backup_path(orig_path):
    possible_result = orig_path + ".backup"
    if os.path.isfile(possible_result):
        return get_backup_path(possible_result)
    else:
        return possible_result


def install_file(file_path, target_path):
    if not os.path.isdir(os.path.dirname(target_path)):
        os.mkdir(os.path.dirname(target_path))
    if os.path.isfile(target_path):
        os.rename(target_path, get_backup_path(target_path))
    os.symlink(file_path, target_path)


def main():
    for k in items:
        install_file(repo_path+k, os.path.expanduser(items[k]))


main()
