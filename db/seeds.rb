# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user_1 = User.create!(name: "Ricky LaFleur", email: "igotmy@grade10.com", google_id: "19023306")
user_2 = User.create!(name: "Bubbles", email: "catlover69@hotmail.com", google_id: "7357151")
user_3 = User.create!(name: "Jim Lahey", email: "supervisor@sunnyvale.ca", google_id: "83465653")
user_4 = User.create!(name: "Randy Bobandy", email: "assistantsupervisor@sunnyvale.ca", google_id: "52785579")
user_5 = User.create!(name: "Gon Freecss", email: "gon@hunterassociation.com", google_id: "58544636")
user_6 = User.create!(name: "Hisoka Morow", email: "hisoka.morow@meteorcity.gov", google_id: "91239464")
user_7 = User.create!(name: "Jenny", email: "jenny@tommytutone.com", google_id: "8675309")

#posts
u1_p1 = Post.create!(description: "This is the text for user 1 post 1", post_status: 0, tone: "melancholy", emotion_id: 1 user: user_1)

#friends
u1_u2 = Friend.create!(follower: user_1, followee: user_2, request_status: 1)
u1_u3 = Friend.create!(follower: user_1, followee: user_3, request_status: 2)
u1_u4 = Friend.create!(follower: user_1, followee: user_3, request_status: 2)
u1_u7 = Friend.create!(follower: user_1, followee: user_7, request_status: 0)


u2_u1 = Friend.create!(follower: user_2, followee: user_1, request_status: 1)
u2_u3 = Friend.create!(follower: user_2, followee: user_3, request_status: 1)
u2_u5 = Friend.create!(follower: user_2, followee: user_5, request_status: 2)

u3_u1 = Friend.create!(follower: user_3, followee: user_1, request_status: 2)
u3_u5 = Friend.create!(follower: user_3, followee: user_5, request_status: 0)
u3_u6 = Friend.create!(follower: user_3, followee: user_6, request_status: 0)

u4_u3 = Friend.create!(follower: user_4, followee: user_3, request_status: 0)
u4_u6 = Friend.create!(follower: user_4, followee: user_3, request_status: 0)

u5_u7 = Friend.create!(follower: user_5, followee: user_7, request_status: 1)
u5_u6 = Friend.create!(follower: user_5, followee: user_6, request_status: 1)
u5_u2 = Friend.create!(follower: user_5, followee: user_2, request_status: 1)

u6_u1 = Friend.create!(follower: user_6, followee: user_1, request_status: 2)
u6_u4 = Friend.create!(follower: user_6, followee: user_4, request_status: 2)

u7_u1 = Friend.create!(follower: user_7, followee: user_1, request_status: 2)
u7_u4 = Friend.create!(follower: user_7, followee: user_4, request_status: 2)
u7_u5 = Friend.create!(follower: user_7, followee: user_4, request_status: 1)
