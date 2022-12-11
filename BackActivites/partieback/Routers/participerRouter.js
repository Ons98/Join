const router=require('express').Router()
const participerController=require('../Controllers/participerController')


router.get("/participerid/:activite",participerController.getParticiperById)
router.post("/createParticiper",participerController.createParticiper)
router.get("/participerid/:utilisateur",participerController.getParticiperByIdu)
router.delete("/deleteParticiper/:id",participerController.deleteParticiper)



module.exports=router