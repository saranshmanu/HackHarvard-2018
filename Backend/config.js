const config = {
	enableCors: true,
	port: process.env.PORT || 8080,
	db_url: 'mongodb://admin:spot-admin1@ds237363.mlab.com:37363/spot-everything'
}

module.exports = config;