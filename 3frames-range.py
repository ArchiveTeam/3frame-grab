#!/usr/bin/env python
import sys

CHARS = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

def code_to_id(code):
  id = 0
  for c in code:
    id = (id * len(CHARS)) + CHARS.index(c)
  return id

def id_to_code(id):
  if id == 0:
    return CHARS[0]
  code = ""
  while id > 0:
    code = CHARS[id % len(CHARS)] + code
    id = id / len(CHARS)
  return code

def code_range(c1, c2):
  for c in xrange(code_to_id(c1), code_to_id(c2) + 1):
    yield id_to_code(c)


if len(sys.argv) == 3:
  code_start = sys.argv[1]
  code_end = sys.argv[2]
else:
  code_start = "0"
  code_end = "Z"

for code in code_range(code_start, code_end):
  print "http://3fram.es/%s" % code

