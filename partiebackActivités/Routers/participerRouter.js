const router=require('express').Router()
const participerController=require('../Controllers/participerController')


router.get("/participerid/:activite",participerController.getParticiperById)
router.post("/createParticiper",participerController.createParticiper)
router.get("/participeruser/:utilisateur",participerController.getParticiperByIdu)
router.delete("/deleteParticiper",participerController.deleteParticiper)
router.get("/getParticiperByUserAct",participerController.getParticiperByUserAct)


module.exports=router