var socket = io.connect('http://localhost:3000/')
while (!pseudo) {
    var pseudo = prompt('quel est votre nom')
}
socket.emit('pseudo', pseudo)
socket.emit('oldWhispers', pseudo)
document.title = pseudo + '-' + document.title;
// Quand on soumet le formulaire
document.getElementById('chatForm').addEventListener('submit', (e) => {

    e.preventDefault();

    // On récupère la valeur dans l'input et on met le input a 0
    const textInput = document.getElementById('msgInput').value;
    document.getElementById('msgInput').value = '';
    const receiver = document.getElementById('receiverInput').value;
    if (textInput.length > 0) {
        socket.emit('newMessage', textInput, receiver);
        //cette fonction pur creer le message en bleu
        if (receiver === "all") {
            createElementFunction('newMessageMe', textInput);
        }

    }
})

//Events
socket.on('newUser', (pseudo) => {

    createElementFunction('newUser', pseudo);
})
socket.on('oldWhispers', (messages) => {
    messages.forEach(message => {
        createElementFunction('oldWhispers', message);
    });
})
socket.on('newUserInDb', (pseudo) => {
    newOption = document.createElement('option');
    newOption.textContent = pseudo;
    newOption.value = pseudo;
    document.getElementById('receiverInput').appendChild(newOption);
})
// On attend un nouveau message
socket.on('newMessageAll', (content) => {
    createElementFunction('newMessageAll', content);
});
// On attend un message privé
socket.on('whisper', (content) => {
    createElementFunction('whisper', content);
});
socket.on('quitUser', (pseudo) => {

    createElementFunction('quitUser', pseudo);
})

// Une personne est en train d'ecrire
socket.on('writting', (pseudo) => {
    document.getElementById('isWritting').textContent = pseudo + ' est en train d\'écrire';
});
// Elle a arrêté d'ecrire
socket.on('notWritting', (pseudo) => {
    document.getElementById('isWritting').textContent = '';
});
// On attend que le serveur demande les anciens messages du channel
socket.on('oldMessages', (messages, user) => {
    messages.forEach(message => {
        if (message.sender === user) {
            createElementFunction('oldMessagesMe', message);
        } else {
            createElementFunction('oldMessages', message);
        }
    });
});


//function
// S'il ecrit on emet 'writting' au serveur
function writting() {
    socket.emit('writting', pseudo);
}

// S'il ecrit plus on emet 'notWritting' au serveur
function notWritting() {
    socket.emit('notWritting');
}
function createElementFunction(element, content) {
    const newElement = document.createElement("div");

    switch (element) {

        case 'newUser':
            newElement.classList.add(element, 'message');
            newElement.textContent = content + ' a rejoint le chat';
            document.getElementById('msgContainer').appendChild(newElement);
            break;
        case 'quitUser':
            newElement.classList.add(element, 'message');
            newElement.textContent = content + ' a quitté le chat';
            document.getElementById('msgContainer').appendChild(newElement);
            break;
        case 'newMessageMe':
            newElement.classList.add(element, 'message');
            newElement.innerHTML = pseudo + ': ' + content;
            document.getElementById('msgContainer').appendChild(newElement);
            break;
        case 'newMessageAll':
            newElement.classList.add(element, 'message');
            newElement.innerHTML = content.pseudo + ': ' + content.message;
            document.getElementById('msgContainer').appendChild(newElement);
            break;
        case 'oldMessages':
            newElement.classList.add(element, 'message');
            newElement.innerHTML = content.sender + ': ' + content.content;
            document.getElementById('msgContainer').appendChild(newElement);
            break;

        case 'oldMessagesMe':
            newElement.classList.add('newMessageMe', 'message');
            newElement.innerHTML = content.sender + ': ' + content.content;
            document.getElementById('msgContainer').appendChild(newElement);
            break;
        case 'whisper':
            newElement.classList.add(element, 'message');
            newElement.textContent = content.sender + ' vous chuchote: ' + content.message;
            document.getElementById('msgContainer').appendChild(newElement);
            break;
        case 'oldWhispers':
            newElement.classList.add(element, 'message');
            newElement.textContent = "message privé de  "+ content.sender +" : " + content.content;
            document.getElementById('msgContainer').appendChild(newElement);
            break;

    }
}