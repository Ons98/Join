const mongoose =require('mongoose');
const schemaPublieractivite= new mongoose.Schema(
    {
        nom:{
            type:String,
            minlength:4,
            required:false,
            unique:true,

        },

},
{timestamps:true}//creation de deus attribut createatt et upadateatt

);
module.exports =mongoose.model('Publieractivite',schemaPublieractivite);