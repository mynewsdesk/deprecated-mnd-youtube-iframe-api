# Cakefile

fs     = require "fs"
{exec} = require "child_process"

tasks = []

REPORTER = "spec"
NODE_MODULES_DIR = "./node_modules/"
TEST_BUILD_DIR = "./test/build/"

task "build", "build javascript", ->
  exec "#{NODE_MODULES_DIR}.bin/coffee -c -o lib src", error

task "minify", "minfy javascript", ->
  exec "#{NODE_MODULES_DIR}.bin/minify lib/youtube_iframe.js lib/youtube_iframe.min.js", error

task "test", "run tests on the console", ->
  exec "#{NODE_MODULES_DIR}.bin/mocha-phantomjs #{TEST_BUILD_DIR}index.html", display

task "open-tests", "launch tests in web browser", ->
  exec "open #{TEST_BUILD_DIR}index.html"

task "build-tests", "compile our coffee", ->
  exec "#{NODE_MODULES_DIR}.bin/coffee --compile --output #{TEST_BUILD_DIR}js/test ./test/"
  exec "#{NODE_MODULES_DIR}.bin/coffee -c -o #{TEST_BUILD_DIR}js/src ./src", error

task "init-tests", "build test environment", ->
  invoke("prep-tests")
  invoke("copy-vendor-libs")
  exec "#{NODE_MODULES_DIR}.bin/coffee build-tests.coffee #{TEST_BUILD_DIR}"

task "prep-tests", "create the test directory structure", ->
  exec "mkdir .p TEST_BUILD_DIR", swallow
  exec "mkdir .p #{TEST_BUILD_DIR}js", swallow
  exec "mkdir .p #{TEST_BUILD_DIR}js/src", swallow
  exec "mkdir .p #{TEST_BUILD_DIR}js/test", swallow
  exec "mkdir .p #{TEST_BUILD_DIR}js/vendor", swallow

task "copy-vendor-libs", "copy testing libs", ->
  vendor = "./test/build/js/vendor/"
  exec "cp #{NODE_MODULES_DIR}mocha/mocha.css #{TEST_BUILD_DIR}mocha.css", swallow
  exec "cp #{NODE_MODULES_DIR}mocha/mocha.js #{vendor}mocha.js", swallow
  exec "cp #{NODE_MODULES_DIR}chai/chai.js #{vendor}chai.js", swallow
  exec "cp #{NODE_MODULES_DIR}sinon/pkg/sinon-1.8.2.js #{vendor}sinon.js", swallow
  exec "cp #{NODE_MODULES_DIR}sinon-chai/lib/sinon-chai.js #{vendor}sinon-chai.js", swallow

task "clean-tests", "clear the test environment", ->
  exec "rm -rf #{TEST_BUILD_DIR}"

display = (err, output) ->
  console.log output

error = (err, output) ->
  throw err if err
  console.log output

swallow = (err, output) ->
  return false
