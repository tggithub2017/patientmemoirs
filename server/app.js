var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);

io.sockets.on('connection', function (socket) {
    socket.on('myClick', function (data) {
        socket.broadcast.emit('myClick', data);
    });
});

http.listen(8880, function () {
  console.log('listening on *:3000');
});