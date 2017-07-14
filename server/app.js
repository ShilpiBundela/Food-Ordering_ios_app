'use-strict'

const express = require('express');
var bodyParser = require('body-parser');
const nodemailer = require('nodemailer');
const app = express();

app.use(bodyParser.json()); // for parsing application/json
app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies

let transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'smartphoneproject1001@gmail.com',
    pass: 'Arpit1109'
  }
});

let mailOptions = {
  from: '"Ratatouille" <smartphoneproject1001@gmail.com>', // sender address
  to: 'shilpi.bundela100@gmail.com', // list of receivers
  subject: 'Hello You Have A New Dish Order :) ✔', // Subject line
  text: '', // plain text body
  html: '' // html body
};

app.get('/', function(request, response) {
  response.status(200);
  response.end();
});

app.post('/', function(request, response) {
	let homecookName = request.body["homecook"];
	let dishName = request.body["name"];
	let timeOfOrder = request.body["date"];

	let messageBody = '<p>Hi ' + homecookName + ',</p><br/><br/>';
	messageBody += '<p> an order for : ' + dishName + '</p></br><p>was placed on : ' + timeOfOrder + '</p>';

	mailOptions.text = messageBody;
	mailOptions.html = messageBody;

  transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
      return console.log(error);
    }
    console.log('Message %s sent: %s', info.messageId, info.response);
  });
  response.status(200);
  response.end();
});

app.listen('3000', function() {
  console.log('listening on port 3000');
});
