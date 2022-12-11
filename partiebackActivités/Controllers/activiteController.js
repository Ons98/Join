const Activite=require('../Models/Activite')
createActivite= async function(req,res){
  try {
    const newActivite={
      nom:req.body.nom,
        date:req.body.date,
        temps:req.body.temps,
        description:req.body.description,
        lieu:req.body.lieu,
        utilisateur:req.body.utilisateur,
        activitePub:req.body.activitePub


    }
    //createActivite//

    await Activite.create(newActivite)//code 2 eme
    return res.status(201).json({
        message:"Hurry! now activity are successfully created.",
        data:newActivite
    })
  } catch (error) {
    return res.status(406).json({
        message:"error " + error.message

    })
    
  }

}
updateActivite = async (req, res) => {
    try {
      await Activite.updateOne({_id: req.params.id }, req.body);
      res.status(200).json({ message: 'activite update' });
    } catch (error) {
      res.status(406).json({ message: 'error is' + error.message });
    }
  };
  deleteActivite = async(req, res) => {
    try {
      await Activite.deleteOne({_id: req.params.id});
      res.status(200).json({ message: 'activite delete' });
    }catch (error) {
      res.status(406).json({ message: 'error is' + error.message });
    }
    
  }; 
  getAllActivites = async (req,res) =>{
    try {
      const activites = await Activite.find({});
      res.status(200).json({message: 'list of activite',data:activites});
  
    }catch(error) {
      res.status(406).json({message: 'error is' +error.message});
    }
  };
  getActiviteById = async (req,res) => {
    try {
      const activite = await Activite.findById({ _id: req.query.id});
      res.status(200).json({ message: 'activite by id', data:activite});
  
    }catch(error) {
      res.status(406).json({ message: 'error is ' + error.message });
    }
  };
  getActiviteByUser = async (req, res) => {
    try {
      const activite = await Activite.find({ utilisateur:req.query.utilisateur});
      res.status(200).json({ message: 'activite by user', data:activite });
    }catch (error) {
    res.status(406).json({ message: 'error is ' + error.message });
  }
};
  getActiviteByName = async (req, res) => {
    try {
      const activite = await Activite.find({ nom:req.query.nom, utilisateur :{$ne:req.query.utilisateur}});
      res.status(200).json({ message: 'activite by name', data:activite });
    }catch (error) {
    res.status(406).json({ message: 'error is ' + error.message });
  };
};

module.exports={createActivite,updateActivite,deleteActivite,getAllActivites,getActiviteById,getActiviteByUser,getActiviteByName}