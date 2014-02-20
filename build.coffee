###
Note - operations are synchronous so that this
plays nicely with the rest of the makefile
###

# Only necessary because spec files are in a flattened
# directory structure
SPEC_FILE_CONVENTION = /\.coffee$/
eco = require './node_modules/eco'
fs  = require 'fs'

buildDir = process.argv[2] or __dirname + '/test/build/'

template = fs.readFileSync __dirname + '/phantom.eco', 'utf-8'

files = fs.readdirSync __dirname + '/test/'
for file in files
  fileName = file
  if fileName.match SPEC_FILE_CONVENTION
    view = 'filename' : '../js/test/' + file.replace('coffee', 'js')
    fs.writeFileSync buildDir + 'html/' + file.replace('coffee', 'html'), (eco.render template, view)
