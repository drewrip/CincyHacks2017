const express = require("express");
const path = require("path");
const solc = require("solc");
const Web3 = require("web3");
const ejs = require("ejs");
const bodyParser = require('body-parser');
const fs = require("fs");
var web3 = new Web3(Web3.providers.HttpProvider("localhost:8545"));
var account = web3.eth.accounts.create().address;
console.log("Contract from  "+ account);
var contractAddr = account;

const input = fs.readFileSync("invenio.sol");
const output = solc.compile(input.toString(), 1);
const bytecode = output.contracts[":invenio"].bytecode;
const abi = JSON.parse(output.contracts[":invenio"].interface);

var obj = new web3.eth.Contract(abi, "0x4531DB99cD9e2a7A9cfA4f8B80F247C5aE28b495");

function uploadPaper(title, link, tag){
	obj.methods.uploadPaper(title, link, tag).call();
}
function addReview(parentUser, postIndex, reviewLink, newRating){
	obj.methods.addReview(parentUser, postIndex, reviewLink, newRating).call();
}
function newUser(firstName, lastName){
	obj.methods.newUser(firstName, secondName).call()
}

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

app.listen(8000);
