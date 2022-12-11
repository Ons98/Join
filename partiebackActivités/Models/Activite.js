const mongoose =require('mongoose');
const schemaActivite =new mongoose.Schema(
    {
  

utilisateur:{

            
    type:mongoose.Types.ObjectId,
    ref:"utilisateur",
    required:true,
},
nom:{
    type:String,
    minlength:4,
    required:false,

},
        activitePub:{


            type:mongoose.Types.ObjectId,
            ref:"publieractivite",
            required:true,
        },
        date:{
            type:String,
            required:false,
        },
        temps:{
            type:String,
            required:false,
        },
         lieu:{
            type:String,
            required:false,
            
        },
        description:{
            type:String,
            
        },
       

       
        
    },
    {timestamps:true}//creation de deus attribut createatt et upadateatt
);
module.exports =mongoose.model('Activite',schemaActivite);