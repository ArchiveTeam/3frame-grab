#!/bin/bash
#
# USAGE:
#   ./dld.sh $LETTER
# where $LETTER is a single letter from a to t
# (t being the current range)
#

letter=$1
if [ -z "$letter" ] ; then
  echo "USAGE:"
  echo " ./dld-3frames.sh LETTER"
  echo "where LETTER is a single letter from a to t"
  echo "(t being the current range)"
  echo
  exit 1
fi
echo "Downloading ${letter}aa to ${letter}ZZ"

USER_AGENT="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27"

mkdir -p data
mkdir -p tmp

"./wget-lua" \
    "-U" "$USER_AGENT" \
    "--lua-script" "3frames.lua" \
    "--no-check-certificate" \
    "--output-document" "tmp/wget.tmp-$$" \
    "--truncate-output" \
    "-e" "robots=off" \
    "--page-requisites" \
    "--tries" "20" \
    "--waitretry" "5" \
    "--warc-file" "data/3frames-${letter}-$( date +'%Y%m%d%H%M%S' )" \
    "--warc-header" "operator: Archive Team" \
    "--warc-header" "3frames-range: ${letter}aa-${letter}ZZ" \
    "-nv" "-o" "tmp/wget-${letter}.log" \
    "http://3fram.es/${letter}aa"
echo ""
echo "Done!"
echo


