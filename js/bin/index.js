#! /usr/bin/env node

const {compile} = require('../src/compiler')

const fs = require('fs')

const path = require('path')

var argv = require('minimist')(process.argv.slice(2))

let dir = path.join(process.cwd(),argv.dir || ".")

let outDir = path.join(process.cwd(),argv.out || ".")

if(!fs.existsSync(outDir)){
    fs.mkdirSync(outDir)
}

const genFiles = ()=>{
    fs.readdir(dir,(err,files)=>{
        if(!err){
            console.log("\n")
            files.filter(name=>path.extname(name) == ".pug").map(name=>{
                let sourceFile = path.join(dir,name)
                fs.readFile(sourceFile,'utf-8',(err,data)=>{
                    let destFile = path.join(outDir,name + ".json")
                    let codeStr = JSON.stringify(compile(data))
                    fs.writeFileSync(destFile,codeStr)
                    console.log(`compile ${sourceFile} ==> ${destFile}`)
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