const Utilisateur = require('../Models/Utilisateur');

const bcrypt = require('bcrypt');
const { randomBytes } = require('crypto');
const { join } = require('path');
const jwt = require('jsonwebtoken');

//var transport = nodemailer.createTransport({
    //host: "smtp.mailtrap.io",
    //port: 2525,
    //auth: {
        //user: "c7fab112df07de",
       // pass: "3a6d9e8516e2a1"
   // }
//});



const DOMAIN = 'http://localhost:4040/'



registerutilisateur = async function (req, res) {
    try {
        const passwordcrypte = bcrypt.hashSync(req.body.password, 10)//password crpter
        const newUtilisateur = new  Utilisateur({ nom:req.body.nom,email: req.body.email,password: passwordcrypte, verified: true })
        await newUtilisateur.save()
        return res.status(201).json({
            message: "Utilisateur est create",
            data: newUtilisateur
        })
    } catch (error) {
        return res.status(406).json({
            message: "error" + error.message
        })
    }

};

login = async function (req, res) {
    try {
        const utilisateur = await Utilisateur.findOne({ email: req.body.email })
        if (!utilisateur) {

            return res.status(406).json({
                message: "email not found"
            })
        }
       
        

        const comparerpassword = bcrypt.compareSync(req.body.password, utilisateur.password)
        if (!comparerpassword) {
            return res.status(406).json({
                message: "password inconnue"
            })
        }
        //creation de token
        const token = jwt.sign({ utilisateur: utilisateur }, "keysercret", { expiresIn: "24h" })

        res.status(201).json({
            message: "utilisateur connection",
            utilisateur: utilisateur, token: token, role: utilisateur.__t

        })

    } catch (error) {
        return res.status(406).json({
            message: "error" + error.message
        })
    }

}
profile = async  (req, res)=> {
    try {
        const utilisateur=await Utilisateur.find({ email: req.params.email});
        return res.status(200).json({
            data: utilisateur
        })

    } catch (error) {
        res.status(406).json({
            message: "error" + error.message
        })
    }
}


module.exports = {registerutilisateur,login,profile}