const Sequelize = require("sequelize")
const sequelize = require("../db")

const User = sequelize.define('user', {
	id: { type: Sequelize.INTEGER, primaryKey: true, autoIncrement: true },
	username: { type: Sequelize.STRING, allowNull: false, unique: true },
	password_hash: { type: Sequelize.STRING, allowNull: false },
	user_type_id: { type: Sequelize.INTEGER, allowNull: false }
})

module.exports = UserType