# Entry point for serverside socket code
module.exports = (io) ->

    io.on 'connection', (err, socket, session) ->
        if err
            return console.log "Unable to authenticate session: #{ err.error }"

        socket.on 'mget', (data) ->
            socket.broadcast.emit 'mpush', 
                userid: session.userid
                data: data