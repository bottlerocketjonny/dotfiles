#!/bin/bash

local_file="$HOME/Documents/Passwords.kdbx"
remote_dir="gdrive:"
file_name="Passwords.kdbx"
remote_path="${remote_dir}${file_name}"

# Fetch local file modification time as a Unix timestamp
if [ -f "$local_file" ]; then
	local_mod_time=$(date -r "$local_file" +%s)
else
	local_mod_time=0
fi

# Fetch remote file details
remote_file_info=$(rclone lsl "$remote_path" | awk '{print $1, $2, $3}')
if [[ -z "$remote_file_info" ]]; then
	remote_mod_time=0
else
	# Parsing the remote file modification time
	remote_date=$(echo "$remote_file_info" | awk '{print $3}')
	remote_time=$(echo "$remote_file_info" | awk '{print $2}')
	# Assuming the date format is YYYY-MM-DD and time format is HH:MM:SS
	remote_mod_time=$(date -d "$remote_date $remote_time" +%s)
fi

# Compare modification times and sync accordingly
if [ "$local_mod_time" -eq 0 ]; then
	echo "Local file does not exist. Attempting to download from Google Drive."
	rclone copy "$remote_path" "$(dirname "$local_file")"
elif [ "$local_mod_time" -gt "$remote_mod_time" ]; then
	echo "Local file is newer. Uploading to Google Drive."
	rclone copy "$local_file" "$remote_dir"
elif [ "$local_mod_time" -lt "$remote_mod_time" ]; then
	echo "Remote file is newer. Downloading to local."
	rclone copy "$remote_path" "$(dirname "$local_file")"
else
	echo "Files are synchronized. No action needed."
fi
