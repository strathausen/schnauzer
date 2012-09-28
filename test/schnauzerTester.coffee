schnauzer = require '../lib/schnauzer'
assert    = require 'assert'
{ exec }  = require 'child_process'

describe 'schnauzer - mustache/handlebars', ->
  describe 'compile', ->
    it 'with partial', ->
      renderer = schnauzer.compile '<bar>{{title}}</bar>', '<foo>{{>body}}</foo>'
      result = renderer title: 'Titlul'

    it 'without partial', ->
      renderer = schnauzer.compile '<bar>{{title}}</bar>'
      result = renderer title: 'Titlul'
      assert.equal result, '<bar>Titlul</bar>'

  describe 'stream', ->
    it 'with partial', (done) ->
      cmd =
        "echo \"{\\\"title\\\":\\\"Titlul\\\"}\" |
          coffee #{__dirname}/../lib/jsonToHtml.coffee
          --body #{__dirname}/template.mustache
          --layout #{__dirname}/layout.mustache"
      exec cmd, (err, stdout, stderr) ->
        assert.equal stdout, '<foo><bar>Titlul</bar>\n</foo>\n'
        assert.equal stderr, ''
        done err

    it 'without partial', (done) ->
      cmd =
        "echo \"{\\\"title\\\":\\\"Titlul\\\"}\" |
          coffee #{__dirname}/../lib/jsonToHtml.coffee
          --body #{__dirname}/template.mustache"
      exec cmd, (err, stdout, stderr) ->
        assert.equal stdout, '<bar>Titlul</bar>\n'
        assert.equal stderr, ''
        done err
