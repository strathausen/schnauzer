###

Stream api wrapper for the handlebars mustache implementation

@author Johann Philipp Strathausen <strathausen@gmail.com>

###

mapStream = require 'map-stream'
hbs       = require 'handlebars'
fs        = require 'fs'
async     = require 'async'

class Schnauzer
  # Template cache
  templates: {}

  # @argument template - The actual body template, not the file name
  # @argument layout - The actual layout template, not the file name
  compile: (template, layout) =>
    tpl = layout or template
    if layout
      hbs.registerPartial 'body', template
    hbs.compile tpl

  # @argument fTemplate - The body template file name
  # @argument fLayout - The layout template file name
  stream: (fTemplate, fLayout) => mapStream (content, cb) =>
    fTemplate or= content.template
    fLayout or= content.layout
    if typeof content is 'string' or content instanceof Buffer
      content = JSON.parse content
    async.parallel
      template: async.apply fs.readFile, fTemplate, 'utf8'

      layout: (cb) ->
        return do cb unless fLayout
        fs.readFile fLayout, 'utf8', cb
    , (err, { template, layout }) =>
      cb null, (@compile template, layout) content

module.exports = new Schnauzer
