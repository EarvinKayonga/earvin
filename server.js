(
    function()
    {
	'use strict';

	var express = require('express'),
	    app = express(),
	    port = process.env.PORT || 10002;

	app.use(favicon(__dirname + '/public/img/favicon.ico'));
	app.listen(port);
	console.log("Server running on " + port);	
    }
)();
