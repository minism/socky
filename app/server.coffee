# Entry point for serverside socket code
module.exports = (io, sockets) ->

    io.on 'connection', (err, socket, session) ->
        if err
            return console.log "Unable to authenticate session: #{ err.error }"

        socket.on 'chat', (msg) ->
            console.log msg
            sockets.emit 'chat', 
                userid: socket.id
                msg: msg
