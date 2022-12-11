const Participer=require('../Models/Participer')
const Activite = require('../Models/Activite')
const Utilisateur = require('../Models/Utilisateur')



createParticiper = async function (req, res) {
    try {
      const newParticiper ={
        utilisateur:req.body.utilisateur,
        activite:req.body.activite

      }
      await Participer.create(newParticiper )
     
      return res.status(201).json({
        message: "Hurry! now Participer are successfully created.",
        data:newParticiper
      })
    } catch (error) {
      return res.status(406).json({
        message: "error" + error.message
      })
    }
  };
getParticiperById = async (req,res) => {
    try {
      const participers = await Participer.find({ activite: req.params.activite});
      res.status(200).json({ message: 'participer by id', data:participers});
  
    }catch(error) {
      res.status(406).json({ message: 'error is ' + error.message });
    }
};
    getParticiperByIdu = async (req,res) => {
        try {
            const participers = await Participer.find({ utilisateur: req.params.utilisateur});
            res.status(200).json({ message: 'participer by user', data:participers});
        
          }catch(error) {
            res.status(406).json({ message: 'error is ' + error.message });
          }
        };


        getParticiperByUserAct = async (req,res) => {
          try {
              const participer = await Participer.find({ activite: req.query.activite,utilisateur: req.query.utilisateur});
              res.status(200).json({ message: 'participer by id', data:participer});
          
            }catch(error) {
              res.status(406).json({ message: 'error is ' + error.message });
            }
          };

  deleteParticiper = async(req, res) => {
    try {
      await Participer.deleteOne({activite: req.query.activite,utilisateur: req.query.utilisateur});
      res.status(200).json({ message: 'particper delete' });
    }catch (error) {
      res.status(406).json({ message: 'error is' + error.message });
    }
    
  }; 




module.exports ={getParticiperById,createParticiper,getParticiperByIdu,deleteParticiper, getParticiperByUserAct}