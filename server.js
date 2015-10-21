(
    function()
    {
	'use strict';

	var express = require('express'),
	    app = express(),
	    port = process.env.PORT || 10002;

	app.use(express.static(__dirname + '/public'));
	app.listen(port);
	console.log("Server running on " + port);	
    }
)();
