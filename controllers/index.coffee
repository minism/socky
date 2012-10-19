check = require('validator').check

auth = require('../middleware').auth

# Routes
module.exports = (app) ->

    # Application page
    app.get '/', auth, (req, res) ->
        res.render 'index',
            title: req.session.userid

    # Login
    app.get '/login', (req, res) ->
        res.render 'login'
    app.post '/login', (req, res) ->
        # Form validation
        username = req.body.username or ''
        try
            check(username, "Username must be alphanumeric, 3-32 characters.").isAlphanumeric().len(3,32)
        catch e
            req.error e.message
            return res.render 'login'

        # Authenticate
        req.session.userid = username
        res.redirect '/'

    # Logout
    app.get '/logout', (req, res) ->
        req.session.userid = null
        res.redirect '/'
            

