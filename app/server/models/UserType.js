const Sequelize = require("sequelize")
const sequelize = require("../db")

const UserType = sequelize.define('user_type', {
	id: { type: Sequelize.INTEGER, primaryKey: true, autoIncrement: true },
	name: { type: Sequelize.STRING, allowNull: false }
})

module.exports = UserType