var http = require('http'),
    Primus = require('primus'),
    server,
    primus;

server = http.createServer(function(req, res) {
  res.end('OK');
});

primus = new Primus(server, {
  transformer: 'engine.io'
});

server.listen(3001, function() {
  console.log('Open http://localhost:8080 in your browser.');
});
