const router=require('express').Router()
const publieractiviteController=require('../Controllers/publieractiviteController')
router.post("/createPublieractivite",publieractiviteController.createPublieractivite)
router.get("/getAllPubActivites",publieractiviteController.getAllPubActivites)
router.get("/getActid/:id",publieractiviteController.getActid)

module.exports = router

