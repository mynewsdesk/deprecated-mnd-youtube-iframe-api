# Cakefile

{exec} = require "child_process"

REPORTER = "spec"

task "test", "run tests", ->
  exec "NODE_ENV=test
        ./node_modules/.bin/mocha
        --reporter #{REPORTER}
        ", (err, output) ->
          throw err if err
          console.log output

task "build", "build javascript", ->
  exec "./node_modules/.bin/coffee
        -c -o lib src
        ", (err, output) ->
          throw err if err
          console.log output

task "minify", "minfy javascript", ->
  exec "./node_modules/.bin/minify
        lib/youtube_iframe.js
        lib/youtube_iframe.min.js
        ", (err, output) ->
          throw err if err
          console.log output
