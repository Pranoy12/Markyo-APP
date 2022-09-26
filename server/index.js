//IMPOTTS FROM PACKAGES
const express = require('express');
const mongoose = require('mongoose');
const cartRouter = require('./routes/cart');

//IMPORT FROM OTHER FILES
const loginRouter = require("./routes/login");
const signupRouter = require("./routes/signup");

//INIT
const PORT = 3000;
const app = express();
const DB= "mongodb+srv://pranoy_apps:pranoy%401210@cluster0.pmrs7.mongodb.net/?retryWrites=true&w=majority";


//MIDDLEWARE
app.use(express.json());
app.use(signupRouter);
app.use(cartRouter);

//creating api
// app.get("/", (req,res) => {
//     res.json({name: "Pranoy"});
// });
//get,put,post,delete,update ->CRUD

//CONNECTIONS
mongoose.connect(DB).then( () => {
    console.log('Connection Successfull');
}).catch((e) => {
    console.log(e);
});

app.listen(PORT,"0.0.0.0" , () => {
    console.log("CONNECTED TO PORT " + PORT);
}); //localhost if 2nd parameter(ip address) not given
