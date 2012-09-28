###

Stream api wrapper for the handlebars mustache implementation

@author Johann Philipp Strathausen <strathausen@gmail.com>

###

mapStream = require 'map-stream'
hbs       = require 'handlebars'

class Schnauzer
  compile: (template, layout) =>
    tpl = layout or template
    if layout?
      hbs.registerPartial 'body', template
    hbs.compile tpl

  stream: (template, layout) => mapStream (content, cb) =>
    cb null, (@compile template, layout) JSON.parse content

module.exports = new Schnauzer
