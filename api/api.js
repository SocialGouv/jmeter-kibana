var http = require('http'); 
 

// We need a server which relies on our router
var server = http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/json'});
  res.write(JSON.stringify({status: "green"}));
  res.end();
});

// Start it up
server.listen(5000);
