const Sequelize = require("sequelize")
const sequelize = new Sequelize("dashboard", "root", "root", {
    host: "localhost",
    dialect: "postgres",
    define: { timestamps: false },
    operatorsAliases: false
})

module.exports = sequelize

const UserType = require("./models/UserType")
const User = require("./models/User")

User.hasOne(UserType, {foreignKey: "user_type_id"})
UserType.hasMany(User)