# Custom authentication middleware
module.exports = (req, res, next) ->
    if not req.session.userid
        return res.redirect('/login')
    next()

