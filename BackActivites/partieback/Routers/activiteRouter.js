const router=require('express').Router()
const activiteController=require('../Controllers/activiteController')


router.post("/createActivite",activiteController.createActivite)
router.put("/updateActivite/:id",activiteController.updateActivite)
router.delete("/deleteActivite/:id",activiteController.deleteActivite)
router.get("/getactivites",activiteController.getAllActivites)
router.get("/activiteid",activiteController.getActiviteById)
router.get("/activiteuser",activiteController.getActiviteByUser)


router.get("/activitenom",activiteController.getActiviteByName)



module.exports=router