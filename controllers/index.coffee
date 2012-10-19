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
        if req.body.username
            req.session.userid = req.body.username
            return res.redirect '/'
        else
            req.info "Some information"
            req.warn "A warning!"
            req.error "Critical error!!!"
            req.success "Yay, success!"
        res.render 'login'

    # Logout
    app.get '/logout', (req, res) ->
        req.session.userid = null
        res.redirect '/'
            

