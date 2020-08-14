const Promise = require('bluebird');

const Item = require('../models/item');

const util = require('../util/index');
const response = util.response;

// POST request that adds new item
exports.addNewItem = (req, res) => {
	return new Promise((resolve, reject) => {
		const newItem = new Item({
			name: req.body.name,
			description: req.body.description,
			price: parseInt(req.body.price),
			stockLeft: parseInt(req.body.stockLeft) || 0,
			rating: parseInt(req.body.rating) || 0,
			category: req.body.category,
			meta: req.body.meta || {}
		});

		newItem.save()
			.then(() => resolve(response(200, "Successfully added item to database", newItem)))
			.catch(err => {
				console.log(err);
				reject(response(400, "Something went wrong", JSON.stringify(err)))
			});
	});
}

// GET request to get item details
exports.itemDetails = (req, res) => {
	return new Promise((resolve, reject) => {
		if(!req.params.id) reject(response(400, "ID field not provided", new Error("ID field not provided")));
		else {
			Item.findOne({_id: req.params.id})
				.exec()
				.then(item => {
					if(!item) {
						reject(response(400, "Item not found", new Error("Item not found")));
					} else {
						resolve(response(200, "Found item", item));
					}
				})
				.catch(err => reject(response(400, "Something went wrong", err)));
		}
	});
}

// GET request to increase or decrease stock
exports.updateStock = (req, res) => {
	return new Promise((resolve, reject) => {
		// negetive values to decrease stock
		if(!req.query.amount || !req.query.id) {
			reject(response(400, "amount or id fields are missing", new Error("amount or id fields are missing")));
		} else {
			Item.findOne({_id: req.query.id})
				.exec()
				.then(item => {
					if(!item) {
						reject(response(400, "Item not found", new Error("Item not found")));
					} else {
						item.stockLeft += parseInt(req.query.amount);
							item.save()
								.then(() => resolve(response(200, "Successfully updated stock", item)))
								.catch(err => {
									console.log(err);
									reject(response(500, "Something went wrong", err));
								});
					}
				})
				.catch(err => {
					console.log(err);
					reject(response(500, "Something went wrong", err))
				});
		}
	});
}

// GET request to update rating
exports.updateRating = (req, res) => {
	return new Promise((resolve, reject) => {
		// negetive values to decrease stock
		if(!req.query.rating || !req.query.id) {
			reject(response(400, "rating or id fields are missing", new Error("rating or id fields are missing")));
		} else {
			Item.findOne({_id: req.query.id})
				.exec()
				.then(item => {
					if(!item) {
						reject(response(400, "Item not found", new Error("Item not found")));
					} else {
						item.rating = parseInt(req.query.rating);
						item.save()
							.then(() => resolve(response(200, "Successfully updated rating", item)))
							.catch(err => {
								console.log(err);
								reject(response(500, "Something went wrong", err));
							});
					}
				})
		}
	});
}

// GET items of a category
exports.getItemsOfCategory = (req, res) => {
	return new Promise((resolve, reject) => {
		if(!req.query.category) {
			reject(response(400, "No category specified", new Error('No category specified')));
		} else {
			Item.find({category: req.query.category})
				.exec()
				.then(items => resolve(response(200, "Found items", items)))
				.catch(err => reject(response(500, "Something went wrong", err)));
		}
	});
}