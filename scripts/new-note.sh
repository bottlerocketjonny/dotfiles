#!/bin/bash
notes_dir="$HOME/notes"
mkdir -p "$notes_dir"
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

if [ $# -eq 0 ]; then
    note_file="${notes_dir}/note_${timestamp}.md"
else
    filename="$1"
    filename="${filename%.md}"
    note_file="${notes_dir}/${filename}.md"
fi

nvim +"NoNeckPain" "$note_file"
