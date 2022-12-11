const Publieractivite=require('../Models/Publieractivite')
const Activite = require('../Models/Activite')
createPublieractivite = async function (req, res) {
    try {
      const newPublieractivite = new Publieractivite(req.body)
      await newPublieractivite.save()
  
      await Activite.findByIdAndUpdate(req.body.activite, { $push: { Publieractivite: newPublieractivite } }) //add  attribut spublieractivite fi medel activite
  
      return res.status(201).json({
        message: "Hurry! now Activity are successfully created.",
        data: newPublieractivite
      })
    } catch (error) {
      return res.status(406).json({
        message: "error" + error.message
      })
    }
  }

  getAllPubActivites = async (req,res) =>{
    try {
      const publieractivites = await Publieractivite.find({});
      res.status(200).json({data:publieractivites});
  
    }catch(error) {
      res.status(406).json({message: 'error is' +error.message});
    }
  };

  getActid = async (req,res) => {
    try {
      const publieractivites = await Publieractivite.findById({ _id: req.params.id});
      res.status(200).json({ message: 'activite by id', data:publieractivites});
  
    }catch(error) {
      res.status(406).json({ message: 'error is ' + error.message });
    }
  };

  module.exports ={createPublieractivite,getAllPubActivites,getActid }