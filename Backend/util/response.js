const response = (code, message, obj) => {
	const res = {
		code: code,
		message: message,
		obj: obj
	};
	return res;
}

module.exports = response;