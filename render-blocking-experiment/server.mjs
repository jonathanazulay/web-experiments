import express from 'express'
import path from 'path'
const app = express()

app.get('/script-after-ms/:name/:ms.js', (req, res) => {
  res.setHeader('Content-Type', 'application/javascript')
  global.setTimeout(() => {
    res.send(`console.log('Script ${req.params.name} executed at ' + Date.now())`)
    res.end()
  }, req.params.ms)
})

app.get('/style-after-ms/:color/:ms.css', (req, res) => {
  res.setHeader('Content-Type', 'text/css')
  global.setTimeout(() => {
    res.send(`body {background-color: ${req.params.color}; }`)
    res.end()
  }, req.params.ms)
})

app.get('/index.html', (req, res) => {
  res.sendFile(path.resolve() + '/index.html')
})

app.get('/index2.html', (req, res) => {
  res.sendFile(path.resolve() + '/index2.html')
})

app.listen(8080)
