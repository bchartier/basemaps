#!/usr/bin/env python
import json
def load_conf(json_file):
	f = open(json_file, "r")
	json_str = f.read()
	data = json.loads(json_str)
	f.close()
	return data
	
vars = load_conf("json/base.json")
styles = load_conf("json/styles.json")
import sys
from optparse import OptionParser


# these are the preconfigured styles that can be called when creating the final mapfile,
# e.g. with `make STYLE=google`. This will create an osm-google.map mapfile
style_aliases = load_conf("json/style_aliases.json")

parser = OptionParser()
parser.add_option("-l", "--level", dest="level", type="int", action="store", default=-1,
                  help="generate file for level n")
parser.add_option("-g", "--global", dest="full", action="store_true", default=False,
                  help="generate global include file")
parser.add_option("-s", "--style",
                  action="store", dest="style", default="default",
                  help="comma separated list of styles to apply (order is important)")

(options, args) = parser.parse_args()

items = vars.items()
for namedstyle in style_aliases[options.style].split(','):
   items = items + styles[namedstyle].items()

style = dict(items)

if options.full:
   print "###### level 0 ######"
   for k,v in style.iteritems():
      if type(v) is dict:
         print "#define _%s0 %s"%(k,v[0])
      else:
         print "#define _%s0 %s"%(k,v)


   for i in range(1,19):
      print
      print "###### level %d ######"%(i)
      for k,v in style.iteritems():
         if type(v) is dict:
            if not v.has_key(i):
               print "#define _%s%d _%s%d"%(k,i,k,i-1)
            else:
               print "#define _%s%d %s"%(k,i,v[i])
         else:
            print "#define _%s%d %s"%(k,i,v)

if options.level != -1:
   level = options.level
   for k,v in style.iteritems():
      print "#undef _%s"%(k)

   for k,v in style.iteritems():
      print "#define _%s _%s%s"%(k,k,level)
