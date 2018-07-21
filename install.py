#!/usr/bin/env python3

import os
import filecmp

# path where this script resides, rather than `os.getcwd()`
repo_path = os.path.dirname(os.path.realpath(__file__)) + "/"

items = {
        "vimrc"                         : "~/.vimrc",
        "bashrc"                        : "~/.bashrc",
        "stack/config.yaml"             : "~/.stack/config.yaml",
        "config/pip/pip.conf"           : "~/.config/pip/pip.conf",
        "config/fontconfig/fonts.conf"  : "~/.config/fontconfig/fonts.conf",
        }


def get_backup_path(orig_path):
    possible = orig_path + ".backup"
    if os.path.isfile(possible):
        return get_backup_path(possible)
    else:
        return possible


def install_file(file_path, target_path):
    log.I("Installing {source} to {target}"
            .format(source=file_path, target=target_path))
    if not os.path.isdir(os.path.dirname(target_path)):
        log.W("Creating parent directory for {target}"
                .format(target=target_path))
        os.mkdir(os.path.dirname(target_path))
    if os.path.islink(target_path) and os.readlink(target_path)==file_path:
        log.W("Ignoring already-created symbolic link {target}"
                .format(target=target_path))
        return
    if os.path.isfile(target_path) or os.path.islink(target_path):
        backup_path = get_backup_path(target_path)
        log.W("Backing up {target} to {backup}"
                .format(target=target_path, backup=backup_path))
        os.rename(target_path, backup_path)
    os.symlink(file_path, target_path)


class log:
    # log info
    def I(message):
        print('\033[1m'  + "==> " + message + '\033[0m')
    # log warning
    def W(message):
        message = "WARNING: " + message
        print('\033[33m' + "  - " + message + '\033[0m')
    # log error
    def E(message):
        message = "ERROR: " + message
        print('\033[31m' + "  - " + message + '\033[0m')

def main():
    for k in items:
        install_file(repo_path+k, os.path.expanduser(items[k]))


if __name__ == '__main__':
    main()
