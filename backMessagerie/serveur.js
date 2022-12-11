var express = require('express')
var app = express()
var server = require('http').createServer(app)
var mongoose = require('mongoose')

const ObjectId = mongoose.Types.ObjectId;

//On se connecte à la base de données
mongoose.connect('mongodb://127.0.0.1:27017/partieback', { useNewUrlParser: true, useUnifiedTopology: true }, function (err) {
    if (err) {
        console.log(err)
    } else {
        console.log('Connected to mongodb')
    }
})
//On va cherche les models 
require('./model/user.model');
require('./model/chat.model');
require('./model/room.model');
var User = mongoose.model('user');
var Chat = mongoose.model('chat');
var Room = mongoose.model('room');


//On définit le dossier contenant notre CSS et JS
app.use(express.static(__dirname + '/public'));


//router
app.get('/', function (req, res) {
    User.find((err, users) => {
        res.render('index.ejs', { users: users });
    })

});
app.use(function (req, res, next) {
    res.setHeader('content-Type', text / html);
    res.status(404).send('page introuable')

})
//io
var io = require('socket.io')(server);
var connectUsers = [];
//cree un socket pour la nouvelle connexion 
//et enregistrer le pseudo de socket 
io.on('connection', (socket) => {
    socket.on('pseudo', (pseudo) => {
        User.findOne({ pseudo: pseudo }, (err, user) => {
            if (user) {
                socket.pseudo = pseudo;
                socket.broadcast.emit('newUser', pseudo);//envoyer au autre utilisateur qu'un nouveau utilisateur en ligne 
            } else {
                var user = new User();
                user.pseudo = pseudo;
                user.save();
                socket.pseudo = pseudo;
                socket.broadcast.emit('newUser', pseudo);
                socket.broadcast.emit('newUserInDb', pseudo);
            }
        })
        connectUsers.push(socket);
        Chat.find({ receiver: 'all' }, (err, messages) => {
            socket.emit('oldMessages', messages)
        })
    })
    socket.on('newMessage', (message, receiver) => {
        if (receiver === "all") {
            var chat = new Chat();

            chat.sender = socket.pseudo;
            chat.receiver = "all"
            chat.content = message;
            chat.save();

            socket.broadcast.emit('newMessageAll', { message: message, pseudo: socket.pseudo });
        }
        else {
            User.findOne({ pseudo: receiver }, (err, user) => {
                if (!user) {
                    return false
                } else {
                    socketReceiver = connectUsers.find(element => element.pseudo === user.pseudo)

                    if (socketReceiver) {
                        socketReceiver.emit('whisper', { sender: socket.pseudo, message: message })
                    }
                    var chat = new Chat();

                    chat.sender = socket.pseudo;
                    chat.receiver = receiver;
                    chat.content = message;
                    chat.save();

                }
            })

        }

    });
    socket.on('writting', (pseudo) => {
        socket.broadcast.emit('writting', pseudo);
    });
    socket.on('oldWhispers', (pseudo) => {
        Chat.find({ receiver: pseudo }, (err, messages) => {

            if (err) {
                return false;
            } else {
                socket.emit('oldWhispers', messages)
            }

        }).limit(3);
    });

    socket.on('notWritting', () => {
        socket.broadcast.emit('notWritting');
    });

    socket.on('disconnect', () => {
        //on supprime la socket lorsque l'utilisateur se déconnecte
        var index = connectUsers.indexOf(socket);
        if (index > -1) {
            connectUsers.splice(index, 1)
        }
        socket.broadcast.emit('quitUser', socket.pseudo);
    })



})



server.listen(3000, () => { console.log('server is runing') })