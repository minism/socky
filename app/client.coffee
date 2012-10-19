# Entry point for clientside socket code

socket = io.connect('/')

mx = 0
my = 0
clients = {}

$('body').mousemove (e) ->
   mx = e.pageX 
   my = e.pageY

mkcursor = (name) ->
    cursor = $('<span/>').addClass('label label-success').html(name).appendTo($('body'))
    cursor.css('position', 'absolute')

update = () ->
    socket.emit 'mget', 
        x: mx
        y: my

socket.on 'mpush', (data) ->
    el = clients[data.userid] or mkcursor(data.userid)
    clients[data.userid] = el
    el.css('left', data.data.x)
    el.css('top', data.data.y)

setInterval(update, 1000 / 20)
