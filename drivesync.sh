#!/bin/bash

local_file="$HOME/Documents/Passwords.kdbx"
remote_dir="gdrive:"
file_name="Passwords.kdbx"

if [ ! -f "$local_file" ]; then
	echo "Local file does not exist. Attempting to download from Google Drive."
	rclone copy "$remote_dir/$file_name" "$(dirname "$local_file")"
else
	echo "Local file exists. Checking for updates to upload."
	rclone copy "$local_file" "$remote_dir"
	echo "Checking for newer remote file to download."
	rclone copy "$remote_dir/$file_name" "$(dirname "$local_file")"
fi
