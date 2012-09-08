#!/usr/bin/env node
/*
*/
var buffer, fs, path, program, schnauzer, sourceStream;

program = require('commander');

schnauzer = require('../');

path = require('path');

fs = require('fs');

buffer = [];

program.description('').version('0.0.1').option('-t, --template <filename>', 'handlebars mustache template').option('-f, --file <filename>', 'json document').parse(process.argv);

if (program.file) {
  sourceStream = fs.createReadStream(program.file);
} else {
  process.stdin.resume();
  sourceStream = process.stdin;
}

sourceStream.pipe(schnauzer.stream(program.template)).pipe(process.stdout);
