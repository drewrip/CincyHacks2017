const express = require("express");
const path = require("path");
const web3 = require("web3");
const ejs = require("ejs");
const bodyParser = require('body-parser');

var app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(__dirname + '/views'));
app.set('views', './views');
app.set('view engine', 'ejs');


app.get("/", function(req, res){
	res.render("index");
});

function person(first, last){
	this.firstName = first;
	this.lastName = last;
}
var dhruv = new person("Dhruv", "Weaver");

app.post("/dashboard", function (req, res) {
	var body = JSON.parse(body);
	var newPerson = new person(req.body.firstName, req.body.lastName);
    console.log(newPerson.firstName+" "+newPerson.lastName);
});

app.listen(8080);
