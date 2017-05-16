var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);

io.sockets.on('connection', function (socket) {
    console.log("New Connection");
    socket.on('myClick', function (data) {
        console.log("New Message");
        socket.broadcast.emit('myClick', data);
    });

    socket.on('myRequest', function (data) {
        console.log("New Request");
        socket.broadcast.emit('myRequest', data);
    });
});

http.listen(8880, function () {
  console.log('listening on *:3000');
});