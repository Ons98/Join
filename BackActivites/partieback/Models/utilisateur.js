const mongoose = require('mongoose');
const schemautilisateur = new mongoose.Schema(
    {
        email: {
            type: String,
            required: true,
            unique:true,
        },
        password: {
            type: String,
            minlength: 4,
            required: true,
        },
        
        nom: {
            type: String,
            required: false,
        },
       verified:{
        type:Boolean,
        default:false,
       },
       verificationcode:{
        type:String,
       },


    },

    { timestamps: true }
);
module.exports = mongoose.model('utilisateur',schemautilisateur);