#!/bin/python3

import os
import sys
import subprocess


folder = "/home/aman/.dotfiles/hypr/.config/hypr/"


def rename_file(old_filename, new_filename):
    """
    Renames a file from old_filename to new_filename.

    Args:
        old_filename (str): The current name of the file.
        new_filename (str): The desired new name of the file.
    """
    try:
        if not os.path.exists(old_filename):
            print(f"Error: File '{old_filename}' not found.")
            return False

        os.rename(old_filename, new_filename)
        print(f"File '{old_filename}' successfully renamed to '{new_filename}'.")
        return True

    except FileNotFoundError:
        print(f"Error: File '{old_filename}' not found. (FileNotFoundError)")
        return False
    except FileExistsError:
        print(
            f"Error: A file with the name '{new_filename}' already exists. (FileExistsError)"
        )
        return False
    except OSError as e:
        print(
            f"Error: Could not rename file '{old_filename}' to '{new_filename}'. (OSError)"
        )
        print(f"       Details: {e}")
        return False


def main():
    # if len(sys.argv) != 3:
    #     print("Usage: python rename_file.py <old_filename> <new_filename>")
    #     return 1  # Indicate incorrect usage
    #
    # old_filename = sys.argv[1]
    # new_filename = sys.argv[2]

    fileName1 = folder + "hyprland.conf"
    fileName2 = folder + "hyprland.conf.backup2"
    fileBackUp = folder + "hyprland.conf.backup"

    rename_file(fileName1, fileName2)
    rename_file(fileBackUp, fileName1)
    rename_file(fileName2, fileBackUp)

    try:
        result = subprocess.run(
            ["hyprctl", "reload"], capture_output=True, text=True, check=True
        )
        print("Hyprland configuration reloaded successfully.")
        # ... (optional: print output)

    except subprocess.CalledProcessError as e:
        print("Error: Failed to reload Hyprland configuration after renaming file.")
        # ... (print error details)
        return 0  # Indicate successful execution


if __name__ == "__main__":
    sys.exit(main())
