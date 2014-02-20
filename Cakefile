# Cakefile

fs     = require 'fs'
{exec} = require "child_process"

tasks = []

REPORTER = "spec"
MODULES_DIR = "./node_modules/"
TEST_BUILD_DIR = "./test/build/"

task "test", "run tests", ->
  exec "NODE_ENV=test #{MODULES_DIR}.bin/mocha --reporter #{REPORTER}", error

task "build", "build javascript", ->
  exec "#{MODULES_DIR}.bin/coffee -c -o lib src", error

task "minify", "minfy javascript", ->
  exec "./node_modules/.bin/minify lib/youtube_iframe.js lib/youtube_iframe.min.js", error

task "phantomjs", "run tests in phantomjs", ->
  exec "#{MODULES_DIR}.bin/mocha-phantomjs #{TEST_BUILD_DIR}index.html"

task "build-tests", "build test environment", ->
  #invoke("clean-tests")
  invoke("prep-tests")
  invoke("copy-vendor-libs")

  exec "#{MODULES_DIR}.bin/coffee build-tests.coffee #{TEST_BUILD_DIR}"
  exec "#{MODULES_DIR}.bin/coffee --compile --output #{TEST_BUILD_DIR}js/test ./test/"
  exec "#{MODULES_DIR}.bin/coffee -c -o #{TEST_BUILD_DIR}js/src ./src", error
  exec "open #{TEST_BUILD_DIR}index.html"

task "prep-tests", "create the test directory structure", ->
  fs.mkdirSync TEST_BUILD_DIR, (err, output) ->
  fs.mkdirSync "#{TEST_BUILD_DIR}js", (err, output) ->
  fs.mkdirSync "#{TEST_BUILD_DIR}js/src", (err, output) ->
  fs.mkdirSync "#{TEST_BUILD_DIR}js/test", (err, output) ->
  fs.mkdirSync "#{TEST_BUILD_DIR}js/vendor", (err, output) ->

task "copy-vendor-libs", "copy testing libs", ->
  vendor = "./test/build/js/vendor/"
  exec "cp #{MODULES_DIR}mocha/mocha.css #{TEST_BUILD_DIR}mocha.css", error
  exec "cp #{MODULES_DIR}mocha/mocha.js #{vendor}mocha.js", error
  exec "cp #{MODULES_DIR}chai/chai.js #{vendor}chai.js", error
  exec "cp #{MODULES_DIR}sinon/pkg/sinon-1.8.2.js #{vendor}sinon.js", error
  exec "cp #{MODULES_DIR}sinon-chai/lib/sinon-chai.js #{vendor}sinon-chai.js", error

task "clean-tests", "clear the test environment", ->
  exec "rm -rf #{TEST_BUILD_DIR}"

error = (err, output) ->
  throw err if err
  console.log output
