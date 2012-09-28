###

@author 

###

program   = require 'commander'
schnauzer = require './schnauzer'
path      = require 'path'
fs        = require 'fs'
async     = require 'async'

program
  .description('Render json in mustache templates. If the optional
  "layout" template is present, it will wrap around the file
  given in the option "body" whereas "body" will be present
  as a partial named "body" in the "layout" template.')
  .version('0.0.1')
  .option('-b, --body <filename>',
    'handlebars mustache template')
  .option('-l, --layout <filename>',
    'handlebars mustache template (layout, frame)')
  .option('-f, --file <filename>', 'json document')
  .parse process.argv

if program.file
  sourceStream = fs.createReadStream program.file
else
  process.stdin.resume()
  sourceStream = process.stdin

async.parallel
  layout: (cb) ->
    return do cb unless program.layout
    fs.readFile program.layout, 'utf8', cb

  body: async.apply fs.readFile, program.body, 'utf8'
, (err, { layout, body }) ->
  rendererStream = schnauzer.stream body, layout

  sourceStream
    .pipe(rendererStream)
    .pipe(process.stdout)
