const {connect} = require('mongoose');
const{success,error} = require('consola');

const DB = 'mongodb://127.0.0.1:27017/partieback';

const connectDB = async () =>{
    try {
        await connect(DB);
        success({
            message:`Successfully connected with the Database \n ${DB}`,
            badge:true,
        });
    } catch (err) {
        error ({
            message:`Unable to  connected with the Database \n ${err}`,
            badge:true,
        });
        connectDB();
    }
};
module.exports = connectDB();
//
/*mongoose.connect(
    'mongodb://127.0.0.1:27017/partieback',
    console.log('successfully connected with the database')
); */