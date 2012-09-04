# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

 #Master data for roles
 roles = Role.create([{ name: 'Admin User'}, { name: 'Normal User'}])
 
 #Add users and their roles
 admin_user = User.new()
 admin_user.email = "adminuser@testme.com"
 admin_user.password = "password"
 admin_user.roles << roles[0]
 admin_user.save

 normal_user = User.new()
 normal_user.email = "normaluser@testme.com"
 normal_user.password = "password"
 normal_user.roles << roles[1]
 normal_user.save