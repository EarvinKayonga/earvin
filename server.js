(function() {
  'use strict';

  var express = require('express'),
    app = express(),
    fs = require('fs'),
    favicon = require('serve-favicon'),
    port = process.env.PORT || 10002;

  app.set('view engine', 'ejs');
  app.use(express.static(__dirname + "/public"));
  app.use(favicon(__dirname + '/public/assets/favicon.ico'));

  app.all('*', function(req, res) {
    res.render('error', {url: req.url});
  });

  app.listen(port);
  console.log("Server running on " + port);

})();
