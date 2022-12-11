const jwt = require('jsonwebtoken');
const SECRET = 'keysercret';

check_auth = async (req, res, next) => {
    try {
        console.log("gggg")

        const token = req.headers['authorization'];
        if (!token) {
            return res.status(403).json({ message: 'No token' });
        }
        //pour verifier data d'expiration de token et recuperer user
        const decoder = jwt.verify(token, SECRET)
       // console.log(decoder);
        req.user = decoder;
        next();
    } catch (error) {
        res.status(404).json({ message: 'Auth failed ' + error.message });
    }
};

module.exports = check_auth;