const app = require('express')();

const port = 8999;
app.listen(port,()=>{console.log('Listenting on port')});
const fs = require('fs');


let file = fs.readFileSync("/home/web/logs/nginxstatus.log", "utf8");
let arr = file.split(/\r?\n/);

function searchKeyword(arr,keyword) {
    // including header line 
    let newArr = ["Current Time ~ Container Name ~ Container ID ~ CPU Perf ~ Memory Usage ~ Net IO ~ Block IO ~ Memory Perf ~ PID ~ Created at ~ State ~ Status<br>"];
    arr.forEach((line)=> {
        if(line.includes(keyword)){
            line = line + '<br>'
            console.log(line);
            newArr.push(line);
        }
    });
    if (newArr.length === 1) {
        return "Sorry there is nothing to show here!"
    }
    return newArr.join('\r\n');
}

app.get('/',(req,res)=>{
    res.status(200).send(
        res.status(200).send(searchKeyword(arr,""))    )
})

app.get('/logs',(req,res)=>{
    res.status(200).send(
        res.status(200).send(searchKeyword(arr,""))    )
})

app.get('/logs/:keyword',(req,res)=>{
    res.status(200).send(searchKeyword(arr,req.params.keyword))
})
