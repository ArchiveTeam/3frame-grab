#!/bin/bash
#
# USAGE:
#   ./dld.sh $LETTER
# where $LETTER is a single letter from a to t
# (t being the current range)
#

letter=$1
echo "Downloading ${letter}00 to ${letter}ZZ"

USER_AGENT="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27"

mkdir -p data
mkdir -p tmp

"./3frames-range.py" "${letter}00" "${letter}ZZ" |
"./wget-lua" \
    "-U" "$USER_AGENT" \
    "--lua-script" "3frames.lua" \
    "--no-check-certificate" \
    "--directory-prefix" "tmp/tmp-$$" \
    "-e" "robots=off" \
    "--page-requisites" \
    "--max-redirect" "5" \
    "--tries" "20" \
    "--waitretry" "5" \
    "--warc-file" "data/3frames-images-${letter}00-${letter}ZZ-$( date +'%Y%m%d%H%M%S' )" \
    "--warc-header" "operator: Archive Team" \
    "--warc-header" "3frames-images-range: ${letter}00-${letter}ZZ" \
    "-nv" "-o" "tmp/wget-${letter}00-${letter}ZZ.log" \
    "--input-file=-"
echo ""
echo "Done!"
echo

rm -rf "tmp/tmp-$$"

