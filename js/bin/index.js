const {compile} = require('../src/compiler')

const fs = require('fs')

const path = require('path')

var argv = require('minimist')(process.argv.slice(2))



let dir = path.join(process.cwd(),argv.dir)

let outDir = path.join(process.cwd(),argv.out)

if(!fs.existsSync(outDir)){
    fs.mkdirSync(outDir)
}

const genFiles = ()=>{
    fs.readdir(dir,(err,files)=>{
        if(!err){
            files.map(name=>{
                fs.readFile(path.join(dir,name),'utf-8',(err,data)=>{
                    let codeStr = JSON.stringify(compile(data).nodes)
                    return fs.writeFileSync(path.join(outDir,name + ".json"),codeStr)
                })
            })
        }
    })
}

fs.watch(dir,()=>{
    genFiles()
})

genFiles()

// loader(require('./test.pug'))