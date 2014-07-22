var cp = require('child_process');
var dgram = require('dgram');

var s = dgram.createSocket('udp4');
s.bind(9398, '192.168.1.74');

s.on("message", function (msg, rinfo) {
  console.log("Received: " + msg + " from " + rinfo.address + ":" + rinfo.port + ".");
  cp.execFile( 'irsend', ['SEND_ONCE', 'LEGO_Combo_PWM', msg.toString()],
    function(error, stdout, stderr) {
      if (error !== null) {
        console.log('error: ' + error);
      }
    });
  s.send(msg, 0, msg.length, rinfo.port, rinfo.address, function () {
    console.log("Replied.");
  });
});
s.on("listening", function () {
  var address = s.address();
  console.log("Listening on " + address.address + ":" + address.port +".")
});
s.on("close", function () {
  console.log("Port closed.");
});
s.on("error", function (err) {
  console.log("Uh oh! Something went wrong:\n" + err.stack);
  s.close();
});
