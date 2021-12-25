const express=require('express');
const app=express();
const port =3000;
app.get('/',(req,resp)=>{
    resp.sendFile(__dirname+"/index.html");
});
app.post('/register',(req,resp)=>{
    resp.sendFile(__dirname+"/success.html");
});


app.listen(port,()=>{
    console.log(`http://localhost:${port} Express server started `);;
})