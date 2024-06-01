#!/bin/bash

# Define paths
TEMPLATE=~/notes/standup/standup-template.md
STANDUP_DIR=~/notes/standup
YESTERDAY_DATE=$(date -d "yesterday" +%Y-%m-%d)
TODAY_FILE="${STANDUP_DIR}/standup-$(date +%Y-%m-%d).md"
TODAY_FILE_BASENAME=$(basename "$TODAY_FILE")

echo "Preparing standup notes for today..."

# Find the most recent standup file, excluding the template and today's file
MOST_RECENT_FILE=$(find "$STANDUP_DIR" -type f -name 'standup-*.md' ! -name "$TODAY_FILE_BASENAME" ! -name 'standup-template.md' -printf "%T@ %p\n" 2>/dev/null | sort -nr | cut -d' ' -f2- | head -n 1)

# Check if a most recent file was found
if [ -z "$MOST_RECENT_FILE" ]; then
	echo "No recent standup file found. Exiting."
	exit 1
fi

echo "Most recent file found: $MOST_RECENT_FILE"

# Extract "Today" section from the most recent file
TODAY_CONTENT=""
if [ -f "$MOST_RECENT_FILE" ]; then
	TODAY_CONTENT=$(awk '/\*Today\*/{flag=1;next}/\*Time Estimate\*/{flag=0}flag' "$MOST_RECENT_FILE")
	if [ -z "$TODAY_CONTENT" ]; then
		echo "No 'Today' content found in the most recent file."
		TODAY_CONTENT="No updates from previous day."
	fi
else
	echo "Most recent file is not accessible."
	TODAY_CONTENT="No updates from previous day."
fi

# Ensure today's file exists
if [ ! -f "$TODAY_FILE" ]; then
	echo "Today's standup file does not exist. Creating from template..."
	cp "$TEMPLATE" "$TODAY_FILE"
else
	echo "Today's standup file already exists."
fi

# Replace the [YESTERDAY_CONTENT] placeholder with the actual content
sed -i "s/\[YESTERDAY_CONTENT\]/$(echo "$TODAY_CONTENT" | sed ':a;N;$!ba;s/\n/\\n/g;s/\&/\\&/g')/g" "$TODAY_FILE"

# Open today's file in Neovim
nvim "$TODAY_FILE"
