# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
user1 = User.create!(email: 'yolo@gmail.com')
user2 = User.create!(email: 'swag@gmail.com')
hubbard = User.create!(email: 'L.Ron.Hubbard@gmail.com')

ShortenedUrl.destroy_all
url1 = ShortenedUrl.create_for_user_and_long_url!(user1, 'www.google.com')
url2 = ShortenedUrl.create_for_user_and_long_url!(user2, 'www.youtube.com')
url3 = ShortenedUrl.create_for_user_and_long_url!(hubbard, 'www.scientology.com')
url4 = ShortenedUrl.create_for_user_and_long_url!(hubbard, 'www.nationaltrasuremovie.com')
url5 = ShortenedUrl.create_for_user_and_long_url!(hubbard, 'www.congress.gov')


Visit.destroy_all
Visit.record_visit!(user1, url1)
Visit.record_visit!(user2, url1)
Visit.record_visit!(user1, url2)
Visit.record_visit!(user1, url3)
Visit.record_visit!(hubbard, url3)
Visit.record_visit!(hubbard, url3)
Visit.record_visit!(hubbard, url3)
Visit.record_visit!(hubbard, url5)
Visit.record_visit!(hubbard, url2)
Visit.record_visit!(user2, url5)
Visit.record_visit!(user2, url4)

Tag.destroy_all
tag = Tag.create!(name: 'scientology')

Tagging.destroy_all
Tagging.record_tag!(tag, url1)
Tagging.record_tag!(tag, url2)
Tagging.record_tag!(tag, url3)
Tagging.record_tag!(tag, url4)
Tagging.record_tag!(tag, url5)
