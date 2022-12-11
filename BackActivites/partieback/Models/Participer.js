const mongoose =require('mongoose');
const schemaParticiper= new mongoose.Schema(
    {



activite:{
    type:mongoose.Types.ObjectId,
    ref:"activite",
    required:true,
},

utilisateur:{

    type:mongoose.Types.ObjectId,
    ref:"utilisateur",
    required:true,
},
},
{timestamps:true}
);

module.exports =mongoose.model('Participer',schemaParticiper);