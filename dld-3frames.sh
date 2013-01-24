#!/bin/bash
#
# USAGE:
#   ./dld.sh $PREFIX
# where $PREFIX points to a range of gallery pages
#
# example:
#   ./dld.sh 12
# will download the pages 120 to 129
#
#   ./dld.sh
# will dowload pages 0 to 9
#

prefix=$1
echo "Downloading gallery pages ${prefix}0 to ${prefix}9"

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
    "--warc-file" "data/3frames-${prefix}-$( date +'%Y%m%d%H%M%S' )" \
    "--warc-header" "operator: Archive Team" \
    "--warc-header" "3frames-range: ${prefix}0-${prefix}1" \
    "-nv" "-o" "tmp/wget-${prefix}.log" \
    "http://3fram.es/gallery?p=${prefix}0" \
    "http://3fram.es/gallery?p=${prefix}1" \
    "http://3fram.es/gallery?p=${prefix}2" \
    "http://3fram.es/gallery?p=${prefix}3" \
    "http://3fram.es/gallery?p=${prefix}4" \
    "http://3fram.es/gallery?p=${prefix}5" \
    "http://3fram.es/gallery?p=${prefix}6" \
    "http://3fram.es/gallery?p=${prefix}7" \
    "http://3fram.es/gallery?p=${prefix}8" \
    "http://3fram.es/gallery?p=${prefix}9"
echo ""
echo "Done!"
echo


