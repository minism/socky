# Entry point for clientside socket code

socket = io.connect('http://localhost')

# Incoming events
socket.on 'chat', (data) ->
    $('#log').append("<div><strong>#{ data.userid }</strong>: #{ data.msg }</div>")


$ ->
    # Publish chat
    $('#inputform').submit (e) ->
        e.preventDefault()
        socket.emit 'chat', $('#input').val()
        $('#input').val('')