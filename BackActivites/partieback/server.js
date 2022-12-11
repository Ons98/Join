
const express = require('express');
const db = require('./config/db');
const activiteRouter = require('./Routers/activiteRouter');
const publieractiviteRouter = require('./Routers/publieractiviteRouter');
const authRouter = require('./Routers/authRouter');
const participerRouter = require('./Routers/participerRouter');

var port=4040
const app = express();
app.use(express.json());//middlware pour le format json
app.use("/Activite", activiteRouter);
app.use("/Publieractivite", publieractiviteRouter);
app.use("/", authRouter);
app.use("/Participer",participerRouter);
app.listen(port, function () {
    console.log('The server is running,' + 'please,open your browser at http://localhost:%s', port);
})