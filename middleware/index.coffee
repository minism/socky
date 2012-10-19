module.exports =
    
    # Custom authentication middleware
    auth: (req, res, next) ->
        if not req.session.userid
            return res.redirect('/login')
        res.locals.userid = req.session.userid
        next()


    # Messages flash middleware
    messages: (req, res, next) ->
        res.locals.messages = req.session.messages = []
        req.flash = req.flash or (text, type='info') ->
            req.session.messages.push
                text: text,
                type: type
        next()
