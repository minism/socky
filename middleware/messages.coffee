class Message
    constructor: (@text, @type='info', @icon='envelope') ->


# Flash messaging middleware
module.exports = (req, res, next) ->
    # Clear any messages
    messages = res.locals.messages = req.session.messages = []

    # Register shortcut functions
    req.info    = (text) -> messages.push(new Message(text))
    req.success = (text) -> messages.push(new Message(text, 'success', 'ok'))
    req.error   = (text) -> messages.push(new Message("<strong>Error: </strong>#{ text }", 'error', 'exclamation-sign'))
    req.warn    = (text) -> messages.push(new Message("<strong>Warning: </strong>#{ text }", 'warn', 'flag'))

    next()