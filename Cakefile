{exec} = require 'child_process'

findExecutable = (executable, callback) ->
  exec "test `which #{executable}` || echo 'Missing #{executable}'", (err, stdout, stderr) ->
    throw new Error(err) if err
    callback() if callback

build = (callback) ->
  exec 'mkdir -p lib', (err, stdout, stderr) ->
    throw new Error(err) if err
    exec "coffee --compile --output lib/ lib/", (err, stdout, stderr) ->
      throw new Error(err) if err
      callback() if callback
    exec "browserify --standalone Timetress --ignore jquery  ./lib/timetress.js > ./lib/standalone.js"

removeJS = (callback) ->
  exec 'rm -fr lib/', (err, stdout, stderr) ->
    throw new Error(err) if err
    callback() if callback

checkDependencies = (callback) ->
  findExecutable 'coffee', ->
    findExecutable 'mocha', (err, stdout) ->
      (callback or console.log) (stdout)

test = (callback = console.log) ->
  checkDependencies ->
    build ->
      exec "./node_modules/.bin/mocha \
    --reporter spec --require should --compilers coffee:coffee-script/register --colors", (err, stdout) ->
        callback(err) if err
        callback(stdout) if stdout

publish = (callback = console.log) ->
  build ->
    findExecutable 'npm', ->
      exec 'npm publish', (err, stdout) ->
        callback(stdout)

dev_install = (callback = console.log) ->
  build ->
    findExecutable 'npm', ->
      exec 'npm link .', (err, stdout) ->
        callback(stdout)

task 'build', 'Build lib from coffeescript source', -> build()
task 'test', 'Test project', -> test()
task 'publish', 'Publish project to npm', -> publish()
task 'dev-install', 'Install developer dependencies', -> dev_install()
