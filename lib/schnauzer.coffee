###

Stream api wrapper for the handlebars mustache implementation

@author Johann Philipp Strathausen <strathausen@gmail.com>

###
_       = require 'underscore'
mapStream = require 'map-stream'

class Schnauzer
  render: () ->

  stream: (defaults) => mapStream (content, cb) =>
    cb null, @parse content.toString(), defaults

module.exports = new Schnauzer
