module.exports =
    
    # Custom authentication middleware
    auth: (req, res, next) ->
        if not req.session.userid
            return res.redirect('/login')
        next()

