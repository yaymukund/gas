require 'coffee-script/register'

http = require 'http'
Primus = require 'primus'
Client = require './lib/client'
fs = require 'fs'

server = http.createServer (req, res) ->
  res.setHeader('Content-Type', 'text/html')
  fs.createReadStream(__dirname + '/index.html').pipe(res)

primus = new Primus(server, transformer: 'engine.io')

primus.on 'data', (a, b, c, d) ->
  console.log(a, b, c, d)

primus.on 'connection', (socket) ->
  new Client(socket)

primus.on 'disconnection', (socket) ->
  console.log(socket, 'disconnected')

server.listen 3001, ->
  console.log 'Server running at http://localhost:3001'
