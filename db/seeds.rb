seeUser.destroy_all
Post.destroy_all
Comment.destroy_all

posts = []
comments = []

users = User.create([
  {
    name: 'Juan Cristobal Pazos',
    email: 'juancri@pazos.com',
    password: 'password',
    password_confirmation: 'password',
    role: 1
  },
  {
    name: 'Gonzalo Sanchez',
    email: 'gonzalo@sanchez.com',
    password: 'password',
    password_confirmation: 'password',
    role: 0
  },
  {
    name: 'Macarena Standen',
    email: 'maca@standen.com',
    password: 'password',
    password_confirmation: 'password',
    role: 0
  }
])

5.times do
 posts << Post.create(title: Faker::Lorem.sentence(3, true, 4),
                      content: Faker::Lorem.paragraph(20, true, 10),
                      user: users.sample)
end

20.times do
  comments << Comment.create(content: Faker::Lorem.paragraph(2),
                             post: posts.sample,
                             user: users.sample)
end
