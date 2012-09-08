.PHONY: test

compile:
	coffee -j index.js -bc lib/schnauzer.coffee
	coffee -j bin/yamlmd2json.js -bc lib/jsonToHtml.coffee
	chmod +x bin/*.js
	echo '0a\n#!/usr/bin/env node\n.\nw' | ed bin/*.js
test:
	@node_modules/.bin/mocha test/*Tester.coffee
