module.exports =  (req, res, next) => {
	res.header("Access-Control-Allow-Origin", "*");
	res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, x-access-token");

	if (req.method === 'OPTIONS') {
    	// var headers = {};
    	// headers["Access-Control-Allow-Methods"] = "POST, GET, PUT, DELETE, OPTIONS";
		// headers["Access-Control-Allow-Credentials"] = false;        	
		// res.writeHead(200, headers);
        // res.end();
        // next();
        res.header("Access-Control-Allow-Methods", "POST, GET, PUT, DELETE, OPTIONS");
        res.header("Access-Control-Allow-Credentials", "false");
    }
    next();
};
