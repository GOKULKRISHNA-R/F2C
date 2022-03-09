const express = require('express');
const bodyParser = require('body-parser');
const fs = require('fs');
var stream = require('stream');

const mysql = require('mysql');
var http = require('http');
const { url } = require('inspector');

const encoder = bodyParser.urlencoded();

const expressLayouts = require('express-ejs-layouts');

const port = process.env.port || 5000 ;

const app = express();

const bcrypt = require("bcrypt");
const { fstat } = require('fs');

app.use(express.json());

app.use(express.urlencoded({extended:true}));

app.use("./Pubic",express.static("Public"));

app.use(expressLayouts);
app.set('view engine','ejs');

const dbcon = mysql.createConnection({
    host : 'localhost',
    user : 'root',
    password : 'mrmaharaju@',
    database : "gk_db",
});

dbcon.connect(function(err){
    if(err) throw err;
    console.log("Connected");
});

// dbcon.query('select * from gk_db.farmer',(err,res,feilds)=>{
//     console.log(res);    
// });

app.get('/',(req,res)=>{
    res.sendFile(__dirname+'/views/index_f2c.html');
    console.log(req.query);
});

app.get('/B_home',(req,res)=>{
    res.sendFile(__dirname+'/views/B_home.html');
    console.log(req.body);
});
app.get('/F_home',(req,res)=>{
    res.sendFile(__dirname+'/views/F_home.html');
    console.log(req.body);
});
app.get('/F_signup',(req,res)=>{
    res.sendFile(__dirname+'/views/F_signup.html');
    console.log(req.body);
});

app.post("/f_signup",(req,res)=>{
    (async function main(){
        const saltrounds = 10 ;
        const hashpassword = await bcrypt.hash(req.body.pass,saltrounds);
        console.log(hashpassword);
        const ismatch = await bcrypt.compare(req.body.cpass,hashpassword);
        console.log(ismatch);
   if(ismatch == true)
    {
        var sql = "INSERT INTO farmer (f_name,address,kissan_number,phone_number,city,pass) VALUES (?, ?, ? , ?, ?, ?) ";
        var VALUES = [req.body.name,req.body.address,req.body.kissan,req.body.phone,req.body.city,hashpassword];
        dbcon.query(sql,VALUES, function (err, result) {
            if (err) throw err;
                console.log("1 record inserted");
                res.end();
      });
    }
    })();
    console.log(req.body);
});

app.get('/B_signup',(req,res)=>{
    res.sendFile(__dirname+'/views/B_signup.html');
    console.log(req.body);
});

app.post("/b-signup",(req,res)=>{
    (async function main(){
        const saltrounds = 10 ;
        const hashpassword = await bcrypt.hash(req.body.pass,saltrounds);
        console.log(hashpassword);
        const ismatch = await bcrypt.compare(req.body.cpass,hashpassword);
        console.log(ismatch);
   if(ismatch == true)
    {
        var sql = "INSERT INTO buyer (b_name,address,phone_number,city,pass) VALUES (?, ?, ?, ?, ?) ";
        var VALUES = [req.body.name,req.body.address,req.body.phone,req.body.city,hashpassword];
        dbcon.query(sql,VALUES, function (err, result) {
            if (err) throw err;
                console.log("1 record inserted");
                res.end();
      });
    }
    })();
    console.log(req.body);
});

app.get('/Products',(req,res)=>{
    res.render('layout');
    console.log(req.body);
});
app.get('/B_login',(req,res)=>{
    res.sendFile(__dirname+'/views/b_login.html');
    console.log(req.body);
});
app.get('/F_login',(req,res)=>{
    res.sendFile(__dirname+'/views/f_login.html');
    console.log(req.body);
});

app.post("/authentication",encoder,(req,res)=>{

    var username = req.body.phone ;
    var password = req.body.pass ;
    
    console.log(req.body);

    dbcon.query("select * from farmer where phone_number = ? and pass = ?",[username,password],function(error,results,feilds){
        if(results.length > 0){
            res.redirect("./views/F_home");
        }else {
            console.log("Incorrect")
        }
        res.end();
    }); 
});

app.get('/Add_yield',(req,res)=>{
    res.sendFile(__dirname+'/views/Add_yield.html');
    console.log(req.body);
});

app.post("/add_yield",(req,res)=>{
    var sql = "INSERT INTO produce (crop,total_quantity,amount_per_kg,expiry_date,image,description_p) VALUES (?, ?, ?, ?, ?,? ) ";
    var VALUES = [req.body.crop,req.body.quantity,req.body.amount,req.body.date,Buffer.from(req.body.img).toString('base64'),req.body.desc];
    dbcon.query(sql,VALUES, function (err, result) {
        if (err) throw err;
        console.log("1 record inserted");
         res.end();
      });
    console.log(req.body);
});

app.get('*',(req, res) => {
  res.status(404).sendFile('./views/404.html', { root: __dirname });
});

app.listen(port,()=>{
    console.log('@ http://localhost:'+port)
});