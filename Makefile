.PHONY: test

compile:
	coffee --compile --bare --stdio < lib/schnauzer.coffee > index.js
	coffee --compile --bare --stdio < lib/jsonToHtml.coffee > bin/json2html.js
	chmod +x bin/*.js
	echo '0a\n#!/usr/bin/env node\n.\nw' | ed bin/*.js
test: compile
	@node_modules/.bin/mocha --compilers coffee:coffee-script/register test/*Tester.coffee
