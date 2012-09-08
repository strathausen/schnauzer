/*

Stream api wrapper for the handlebars mustache implementation

@author Johann Philipp Strathausen <strathausen@gmail.com>
*/
var Schnauzer, mapStream, _,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

_ = require('underscore');

mapStream = require('map-stream');

Schnauzer = (function() {

  function Schnauzer() {
    this.stream = __bind(this.stream, this);
  }

  Schnauzer.prototype.render = function() {};

  Schnauzer.prototype.stream = function(defaults) {
    var _this = this;
    return mapStream(function(content, cb) {
      return cb(null, _this.parse(content.toString(), defaults));
    });
  };

  return Schnauzer;

})();

module.exports = new Schnauzer;
