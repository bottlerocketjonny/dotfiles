#!/bin/sh

# urlpath=$(
# 	curl "https://www.bing.com/HPImageArchive.aspx?format=rss&idx=0&n=1&mkt=en-US" |
# 		xmllint --xpath "/rss/channel/item/link/text()" - |
# 		sed 's/1366x768/1920x1080/g'
# )
# curl "https://www.bing.com$urlpath" |
# 	feh --bg-fill -

# Fetch the main page HTML content
main_page_html=$(curl -s "https://bingwallpaper.anerg.com/")

# Extract the URL for the "Today's Wallpaper" page
today_url=$(echo "$main_page_html" | grep -oP '(?<=<a href=")[^"]*(/detail/us/[^"]*)' | head -n 1)

# Check if the today's wallpaper URL is empty
if [ -z "$today_url" ]; then
	echo "Failed to extract the Today's Wallpaper page URL."
	exit 1
fi

# Fetch the "Today's Wallpaper" page HTML content
today_page_html=$(curl -s "https://bingwallpaper.anerg.com$today_url")

# Extract the URL for the "Download 4K" button
image_url=$(echo "$today_page_html" | grep -oP '(?<=<a href=")[^"]*(imgproxy[^"]*w:3840[^"]*)' | head -n 1)

# Check if the 4K image URL is empty
if [ -z "$image_url" ]; then
	echo "Failed to extract the 4K image URL."
	exit 1
fi

# Print the 4K image URL for verification
echo "4K image URL: $image_url"

# Download and set the wallpaper using feh
curl -s "$image_url" | feh --bg-fill -
