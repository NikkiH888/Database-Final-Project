const db = require("../db")
const User = require("../models/User")
const UserType = require("../models/UserType")

exports.find_all_users = done => {
	User.findAll().then(users => {
		done(null, users)
	}).catch(error => {
		done(error)
	})
}

exports.find_all_user_types = done => {
	UserType.findAll().then(user_types => {
		done(null, user_types)
	}).catch(error => {
		done(error)
	})
}

exports.create_user = (user, done) => {
	User.create(user).then(() => {
		done(null)
	}).catch(error => {
		done(error)
	})
}

exports.create_user_type = (user_type, done) => {
	UserType.create(user_type).then(() => {
		done(null)
	}).catch(error => {
		done(error)
	})
}

exports.find_user_by_id = (id, done) => {
    User.findById(id).then(user => {
        done(null, user)
    }).catch(error => {
        done(error)
    })
} 

exports.find_user_type_by_id = (id, done) => {
	UserType.findById(id).then(user_type => {
		done(null, user_type)
	}).catch(error => {
		done(error)
	})
}