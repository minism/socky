# Dependencies
express          = require 'express'
http             = require 'http'
path             = require 'path'
ect              = require 'ect'
socketio         = require 'socket.io'
SessionSockets   = require 'session.socket.io'

middleware       = require './middleware'


# Constants
VIEW_PATH    = path.join(__dirname, 'views')
# STATIC_PATH  = path.join(__dirname, 'static')
# STATIC_URL   ='/static'


# Define cookie parser and session storage externally so they can be 
# shared between express and socket.io
session_store = new express.session.MemoryStore
cookie_parser = express.cookieParser('SECRET')


# Express server configuration and middlware
app = express()
app.configure ->
    # Server port
    app.set 'port', process.env.PORT or 3000

    # View config
    app.set 'views', VIEW_PATH
    app.set 'view engine', 'html'

    # Use ect templates
    app.engine 'html', ect({root: VIEW_PATH}).render

    # Coffeescript/LESS compilation and bundling
    app.use app.routes
    app.use require('connect-assets')({src: 'public'})

    # Static file serving
    app.use '/public', express.static(path.join(__dirname, 'public'))
       
    # Favicon url shortcut
    app.use express.favicon('')

    # Logging
    app.use express.logger('dev')

    # Request body parsing (JSON, ...)
    app.use express.bodyParser()

    # Allow controllers with methods PUT, DELETE, etc...
    app.use express.methodOverride()

    # Signed cookie parsing
    app.use cookie_parser

    # Session
    app.use express.session({ store: session_store })

    # DUMMY app storage, should eventually be a DB
    app.store =
        users: {}

    # Application-wide middleware
    app.use middleware.messages


# Register application routes
require('./controllers')(app)


# Boot HTTP server
serv = http.createServer(app).listen app.get('port'), ->
    console.log "Server listening on port #{ app.get('port') }"


# Attach socket.io
io = socketio.listen(serv)


# Initialize session.socket.io with shared cookie/storage
session_io = new SessionSockets(io, session_store, cookie_parser)


# Load server code
require('./app/server')(session_io, io.sockets)
