;

var express = require('express');
var http = require('http');
var path = require('path');
var bodyParser = require('body-parser');

app = express();
app.configure(function() {
    app.set('views', __dirname + '/app/views');
    app.set('view engine', 'jade');
    app.use(express.static(path.join(__dirname, 'public')));
    app.use(express.cookieParser());
    app.use(express.methodOverride());
    app.use(express.session({secret: 'keyboard cat'}));
    app.use(bodyParser.json());  
    app.use(express.json());       // to support JSON-encoded bodies
    app.use(express.urlencoded()); // to support URL-encoded bodies

    app.locals.basedir = path.join(__dirname, '/app/views');
    app.use(app.router);
    app.basepath = __dirname;

    require('./routes')();
    http.createServer(app).listen(3000, function() {
        console.log('Server Started');
    });
});
