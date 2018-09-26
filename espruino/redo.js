// TODO read from flash
const wifi_pass = "mywifi";
const wifi_ssid = "mypass";
const redo_id = "42";
const api_host = "www.example.com";

I2C1.setup({"scl":D2,"sda":D0,"bitrate":100000});
var MPU = require("MPU6050").connect(I2C1);
var Wifi = require("Wifi");
var Http = require("http");
var face = 0;

// TODO read classifiers from flash
var CLASSIFIERS = {
  1: {theta:28.223955, beta:[-0.006770, 0.232152, -0.000293, 0.003835]},
  2: {theta:59.745324, beta:[0.003146, 0.775132, 0.007922, -0.004895]},
  3: {theta:-0.195667, beta:[-1.002909, 0.778002, -0.031938, -0.012457]},
  4: {theta:48.720307, beta:[0.560011, 0.713442, 0.007929, -0.003330]},
  5: {theta:84.030722, beta:[-3.371715, 0.667267, -0.030930, -0.009785]},
  6: {theta:2.995697, beta:[0.940258, 0.706177, -0.029392, -0.005099]},
  7: {theta:44.899578, beta:[0.534816, -0.665037, 0.007507, -0.004819]},
  8: {theta:81.137955, beta:[-3.333497, -0.688953, -0.031154, -0.011106]},
  9: {theta:14.077885, beta:[0.895343, -0.691843, -0.027739, 0.007309]},
  10: {theta:55.900638, beta:[-0.007448, -0.806771, 0.007755, -0.010931]},
  11: {theta:7.292768, beta:[-1.188119, -0.799748, -0.032398, -0.006913]},
  12: {theta:30.394956, beta:[0.001298, -0.229135, 0.000284, 0.003906]}
};

function xyz_to_X(xyz) {
  const RAD = 180.0/Math.PI;
  yaw = Math.atan(xyz[1]/xyz[0])*RAD;
  pitch = Math.atan(
      xyz[2]/Math.sqrt(Math.pow(xyz[0],2) + Math.pow(xyz[1],2))
  ) * RAD;
  return [yaw, pitch, Math.pow(yaw, 2), Math.pow(pitch, 2)];
}

function predict(x, theta, b) {
  xb = x[0] * b[0] + x[1] * b[1] + x[2] * b[2] + x[3] * b[3];
  return 1/(1+Math.exp(theta-xb));
}

function classify(x) {
  const PROB_CUTOFF = 0.9;
  var best_face_value = 0.0;
  var best_face = 0;
  for (i=1;i<=12;i++) {
    p = predict(x, CLASSIFIERS[i].theta, CLASSIFIERS[i].beta);
    if (p > best_face_value && p > PROB_CUTOFF) {
      best_face_value = p;
      best_face = i;
    }
  }
  return best_face;
}

function get_face() {
  return classify(xyz_to_X(MPU.getAcceleration()));
}

function report_face() {
  payload = "{redoid:" + redo_id + ", face:" + face +"}";
  api_request_options = {
    host:api_host,
    port:80,
    path: "/api/report",
    method: "POST",
    protocol: "http:",
    headers: {
      "Accept": "application/json",
      "Cache-Control": "no-cache",
      "Content-Type": "application/json",
      "Content-Length": "" + payload.length
    }
  };
  console.log("report: " + payload);
  req = Http.request(api_request_options, function(res) {
      res.on('data', function(data) {
        console.log("HTTP> " + data);
      });
      res.on('close', function(data) {
        console.log("Connection closed");
        console.log("Wifi disconnecting");
        Wifi.disconnect();
      });
    });
  req.on('error', function(err) {
    console.log("Error: " + err.code + ", msg: " + err.msg);
  });
  console.log("Sending");
  req.end(payload);
}

function send_to_api() {
  console.log("Spinning up wifi");
  Wifi.connect(wifi_ssid, {password:wifi_pass}, function(ap){
    console.log("Wifi connected:" + ap);
    Wifi.getIP(function(err, ip){
      console.log("Ip: " + ip.ip);
    });
    console.log("Reporting face");
    report_face();
  });
}

function sample_face(sample, old_face) {
  const NUM_SAMPLES=5;
  new_face = get_face();
  if(old_face === 0 || new_face == old_face){
    if(sample < NUM_SAMPLES) {
      setTimeout(sample_face, 100, sample+1, new_face);
    }else{
       if (face != new_face) {
         face = new_face;
         console.log("face change: ", face);
         send_to_api();
       }
    }
  }
}

setInterval(sample_face, 60000, 0, 0);
save();
