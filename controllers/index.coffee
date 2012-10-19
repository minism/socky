_     = require 'lodash'
check = require('validator').check

auth = require('../middleware').auth

# Routes
module.exports = (app) ->

    # Application page
    app.get '/', auth, (req, res) ->
        res.render 'index',
            users: _.keys(app.store.users)

    # Login
    app.get '/login', (req, res) ->
        res.render 'login'
    app.post '/login', (req, res) ->
        # Form validation
        username = req.body.username or ''
        try
            check(username, "Username must be alphanumeric, 3-32 characters.").isAlphanumeric().len(3,32)
            check(username, "That username already exists").notIn(_.keys(app.store.users))
        catch e
            req.error e.message
            return res.render 'login'

        # Authenticate
        req.session.userid = username
        app.store.users[username] = true
        res.redirect '/'

    # Logout
    app.get '/logout', (req, res) ->
        delete app.store.users[req.session.userid]
        delete req.session.userid
        res.redirect '/'
            

