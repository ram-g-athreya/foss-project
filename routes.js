;
var formidable = require('formidable'),
        util = require('util'),
        fs = require('fs'),
        sys = require('sys'),
        exec = require('child_process').exec;

module.exports = function() {
    app.get('/', function(req, res) {
        res.render('index');
    });

    app.post('/upload', function(req, res) {
        // parse a file upload
        var form = new formidable.IncomingForm();
        form.parse(req, function(err, fields, files) {

            //Write to CSV file within r folder
            fs.readFile(files.upload.path, function(err, data) {
                var newPath = __dirname + "/r/input.csv";
                fs.writeFile(newPath, data, function(err) {
                    function puts(error, stdout, stderr) {
                        res.render('upload');
                    }
                    exec("Rscript r/init.R", puts);
                });
            });
        });

        return;
    });

    app.get('/predict', function(req, res) {
        res.render('predict');
    });

    app.post('/predict', function(req, res) {
        var json = JSON.parse(req.body.json);
        var key_string = '"",', value_string = '"",';
        
        for(var i in json){
            key_string += json[i].name + ',';
            value_string += json[i].value + ',';
        }
        key_string += 'Dropout'
        value_string += '""';
        var string = key_string + '\n' + value_string + '\n';        
        
        fs.writeFile('r/predict-input.csv', string, function(err) {
            function puts(error, stdout, stderr) {
                fs.readFile('r/output', 'utf-8', function(err, data) {
                    res.end(data);
                });
            }
            exec("Rscript r/prediction.R", puts);
        });
    });

};
