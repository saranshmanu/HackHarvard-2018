const router = require('express').Router();

const itemController = require('../controllers/itemController');

router.get('/', (req, res) => {

});

router.post('/new', (req, res) => {
	itemController.addNewItem(req, res)
		.then(info => res.status(info.code).json(info))
		.catch(err => {
			console.log(err);
			res.status(err.code).json(err)
		});
});

router.get('/find/:id', (req, res) => {
	itemController.itemDetails(req, res)
		.then(info => res.status(info.code).json(info))
		.catch(err => res.status(err.code).json(err));
});

router.get('/updateStock', (req, res) => {
	itemController.updateStock(req, res)
		.then(info => res.status(info.code).json(info))
		.catch(err => res.status(err.code).json(err));
});

router.get('/updateRating', (req, res) => {
	itemController.updateRating(req, res)
		.then(info => res.status(info.code).json(info))
		.catch(err => res.status(err.code).json(err));
});

router.get('/category', (req, res) => {
	itemController.getItemsOfCategory(req, res)
		.then(info => res.status(info.code).json(info))
		.catch(err => res.status(err.code).json(err));
});

module.exports = router;