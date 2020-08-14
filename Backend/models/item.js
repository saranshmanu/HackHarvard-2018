const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const itemSchema = new Schema({
	name: {
		type: String,
		required: true
	},

	description: {
		type: String
	},

	price: {
		type: Number,
		required: true,
		default: 0
	},

	stockLeft: {
		type: Number,
		required: true,
		default: 0,
		min: 0
	},

	rating: {
		type: Number,
		default: 0,
		min: 1,
		max: 5
	},

	category: {
		type: String
	},

	meta: {
		type: Object
	}
});

const Item = mongoose.model('Item', itemSchema);

module.exports = Item;