# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Post.destroy_all
Comment.destroy_all

users = User.create([
  { name: 'Juan Cristobal Pazos', email: 'juancri@pazos.com', password: 'password', password_confirmation: 'password', role: 1 },
  { name: 'Gonzalo Sanchez', email: 'gonzalo@sanchez.com', password: 'password', password_confirmation: 'password', role: 0 },
  { name: 'Macarena Standen', email: 'maca@standen.com', password: 'password', password_confirmation: 'password', role: 0 }
])

posts = Post.create([
  { title: Faker::Lorem.sentence(3, true, 4), content: Faker::Lorem.paragraph(20, true, 10), user: users.first },
  { title: Faker::Lorem.sentence(3, true, 4), content: Faker::Lorem.paragraph(30, true, 20), user: users.last },
  { title: Faker::Lorem.sentence(3, true, 4), content: Faker::Lorem.paragraph(20, true, 15), user: users.last },
  { title: Faker::Lorem.sentence(3, true, 4), content: Faker::Lorem.paragraph(40, true, 25), user: users[1] }
])

comments = Comment.create([
  { content: Faker::Lorem.paragraph(2), post: posts.first, user: users.last },
  { content: Faker::Lorem.paragraph(3), post: posts.last, user: users.first },
  { content: Faker::Lorem.paragraph(1), post: posts.first, user: users.first },
  { content: Faker::Lorem.paragraph(3), post: posts.first, user: users[1] },
  { content: Faker::Lorem.paragraph(4), post: posts[1], user: users.last },
  { content: Faker::Lorem.paragraph(3), post: posts[1], user: users[1] },
  { content: Faker::Lorem.paragraph(1), post: posts[2], user: users[1] },
  { content: Faker::Lorem.paragraph(2), post: posts[2], user: users.last },
  { content: Faker::Lorem.paragraph(3), post: posts.last, user: users[1] },
  { content: Faker::Lorem.paragraph(2), post: posts.last, user: users[2] }
])