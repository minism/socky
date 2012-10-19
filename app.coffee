# Dependencies
express = require 'express'
http    = require 'http'
path    = require 'path'
ect     = require 'ect'

routes = require './routes'


# Constants
VIEW_PATH    = path.join(__dirname, 'views')
STATIC_PATH  = path.join(__dirname, 'static')
STATIC_URL   ='/static'


# Server configuration and middlware
app = express()
app.configure ->

    # Server port
    app.set 'port', process.env.PORT or 3000

    # View config
    app.set 'views', VIEW_PATH
    app.set 'view engine', 'html'

    # Use ect templates
    app.engine 'html', ect({root: VIEW_PATH}).render

    # TODO
    # Less compiling - NOT CURRENTLY WORKING
    # app.use require('less-middleware')({src: STATIC_PATH})

    # Static file serving
    app.use STATIC_URL, express.static(STATIC_PATH)
       
    # Favicon url shortcut
    app.use express.favicon('')

    # Logging
    app.use express.logger('dev')

    # Request body parsing (JSON, ...)
    app.use express.bodyParser()

    # Allow controllers with methods PUT, DELETE, etc...
    app.use express.methodOverride()

    # Signed cookie parsing
    app.use express.cookieParser('SECRET')

    # Session
    app.use express.session()


# Register application routes
require('./routes')(app)


# Run server
http.createServer(app).listen app.get('port'), ->
    console.log "Server listening on port #{ app.get('port') }"
