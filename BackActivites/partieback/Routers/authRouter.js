const router = require('express').Router()
const AuthController = require('../Controllers/authController')
const checkauthentication = require('../Midlewares/checkauthentication');


router.post("/registerutilisateur", AuthController.registerutilisateur)
router.post("/login", AuthController.login)
router.get("/profile/:email", AuthController.profile)

module.exports = router