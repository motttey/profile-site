# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@user_detail = UserDetail.new
@user_detail.name = 'Tagosaku Mochiduki'
@user_detail.username = 'mttg'
@user_detail.nickname = 't'
@user_detail.about = 'Hello, I am Mochiduki.'
@user_detail.save

@user_detail = UserDetail.new
@user_detail.name = 'Tago'
@user_detail.username = 'tg'
@user_detail.nickname = 't'
@user_detail.about = 'Hi. I am Tagosaku.'
@user_detail.save