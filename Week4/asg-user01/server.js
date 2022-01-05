// const express = require('express');
// const server = express();
// const port=3000;
// const cors=require('cors');
// const res = require('express/lib/response');
// const { response } = require('express');
// const { compileETag } = require('express/lib/utils');
// const cors_option = { origin: "http://localhost:4200",optionSuccessStatus:200 };
// server.use(express.json());
// server.use(express.urlencoded({extended:true}));
// server.use(express.cors(cors_option));

// const USERS = [
//   { id: 1, userName: "satyam" },
//   { id: 2, userName: "satyam" },
//   { id: 3, userName: "satyam" },
// ];
// server.get('/',(req,resp)=>{
//     resp.send("express is working");
// })

// server.get('/users',(req,resp)=>{
//     resp.setHeader("Content-type","application/json");
//     resp.send(USERS)
// })
// server.listen(post,()=>{
//     console.log("http://localhost:3000")
// })

const express = require("express");
const server = express();
const cors = require("cors");
const CORS_OPTIONS = {
  origin: "http://localhost:4200",
  optionsSuccessStatus: 200,
};
const port = 3000;

server.use(cors(CORS_OPTIONS));
server.use(express.json());
server.use(express.urlencoded({ extended: true }));

const USERS = [
  {
    id: 1,
    name: "sayali",
  },
  {
    id: 2,
    name: "Sachin",
  },
  {
    id: 3,
    name: "shruti",
  },
];

// #############################################################################//

server.get("/", (req, res) => {
  res.send("express is working");
});

server.get("/users", (req, res) => {
  res.setHeader("Content-Type", "application/json");
  res.send(USERS);
  // res.send('Hello Again Madhav!');
});

server.listen(port, () => {
  console.log(`http://localhost:${port} running`);
});