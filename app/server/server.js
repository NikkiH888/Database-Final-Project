const bodyParser = require("body-parser")
const sequelize = require("./db")
const express = require("express")
const app = express()
const port = 8000

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: true}))

require("./routes")

sequelize.authenticate()
.then(() => {
    sequelize.sync({force: true}).then(() => {
        app.listen(port, () => {
            console.log("Server listening on port " + port)
        })
    })
})
.catch(err => {
    return console.log(err)
})