module.export = (app) => {
	app.get('/', (req, res) => {
		res.json({status: 200, data: "Hello World"})
	})
}