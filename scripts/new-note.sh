#!/bin/bash

notes_dir="$HOME/notes"

mkdir -p "$notes_dir"

timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

note_file="${notes_dir}/note_${timestamp}.md"

nvim +"NoNeckPain" "$note_file"
