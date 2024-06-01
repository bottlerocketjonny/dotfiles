#!/bin/bash

# Update this with files to sync
files=(
	"$HOME/Documents/Passwords.kdbx"
	"$HOME/notes/todo/personal.md"
	"$HOME/notes/todo/work.md"
)

remote_dir="gdrive:"

extract_filename() {
	local filepath="$1"
	local filename="${filepath##*/}"
	echo "$filename"
}

for file in "${files[@]}"; do

	file_name=$(extract_filename "$file")
	remote_path="${remote_dir}${file_name}"

	# Fetch local file modification time as a Unix timestamp
	if [ -f "$file" ]; then
		local_mod_time=$(date -r "$file" +%s)
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
		echo "File '$file' does not exist locally. Attempting to download from Google Drive."
		rclone copy "$remote_path" "$(dirname "$file")"
	elif [ "$local_mod_time" -gt "$remote_mod_time" ]; then
		echo "Local file '$file' is newer. Uploading to Google Drive."
		rclone copy "$file" "$remote_dir"
	elif [ "$local_mod_time" -lt "$remote_mod_time" ]; then
		echo "Remote file '$file' is newer. Downloading to local."
		rclone copy "$remote_path" "$(dirname "$file")"
	else
		echo "File '$file' is synchronized. No action needed."
	fi
done
