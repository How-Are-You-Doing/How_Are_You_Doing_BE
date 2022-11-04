# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# require 'csv'

user_1 = User.create!(name: "Ricky LaFleur", email: "igotmy@grade10.com", google_id: "19023306")
user_2 = User.create!(name: "Bubbles", email: "catlover69@hotmail.com", google_id: "7357151")
user_3 = User.create!(name: "Jim Lahey", email: "supervisor@sunnyvale.ca", google_id: "83465653")
user_4 = User.create!(name: "Randy Bobandy", email: "assistantsupervisor@sunnyvale.ca", google_id: "52785579")
user_5 = User.create!(name: "Gon Freecss", email: "gon@hunterassociation.com", google_id: "58544636")
user_6 = User.create!(name: "Hisoka Morow", email: "hisoka.morow@meteorcity.gov", google_id: "91239464")
user_7 = User.create!(name: "Jenny", email: "jenny@tommytutone.com", google_id: "8675309")
#emotions

e1 = Emotion.create!(term: "Affectionate")
e2 = Emotion.create!(term: "Confident")
e3 = Emotion.create!(term: "Grateful")
e4 = Emotion.create!(term: "Peaceful")
e5 = Emotion.create!(term: "Engaged")
e6 = Emotion.create!(term: "Excited")
e7 = Emotion.create!(term: "Inspired")
e8 = Emotion.create!(term: "Joyful")
e9 = Emotion.create!(term: "Exhilarated")
e10 = Emotion.create!(term: "Refreshed")
e11 = Emotion.create!(term: "Hopeful")
e12 = Emotion.create!(term: "Afraid")
e13 = Emotion.create!(term: "Confused")
e14 = Emotion.create!(term: "Embarrassed")
e15 = Emotion.create!(term: "Tense")
e16 = Emotion.create!(term: "Annoyed")
e17 = Emotion.create!(term: "Disconnected")
e18 = Emotion.create!(term: "Fatigue")
e19 = Emotion.create!(term: "Vulnerable")
e20 = Emotion.create!(term: "Angry")
e21 = Emotion.create!(term: "Disquiet")
e22 = Emotion.create!(term: "Pain")
e23 = Emotion.create!(term: "Aversion")
e24 = Emotion.create!(term: "Sad")

# cmd = "rake csvload:emotions"


#posts
u1_p1 = Post.create!(description: "This is the text for user 1 post 1", post_status: 0, tone: "melancholy", emotion: e1, user: user_1)
u1_p2 = Post.create!(description: "This is the text for user 1 post 2", post_status: 0, tone: "happy", emotion_id: e2.id, user: user_1)
u1_p3 = Post.create!(description: "This is the text for user 1 post 3", post_status: 0, tone: "sad", emotion_id: e3.id, user: user_1)
u1_p4 = Post.create!(description: "This is the text for user 1 post 4", post_status: 0, tone: "angry", emotion_id: e4.id, user: user_1)

u2_p1 = Post.create!(description: "This is the text for user 2 post 1", post_status: 1, tone: "hyped up", emotion_id: 1, user: user_2)
u2_p2 = Post.create!(description: "This is the text for user 2 post 2", post_status: 1, tone: "relaxed", emotion_id: 5, user: user_2)
u2_p3 = Post.create!(description: "This is the text for user 2 post 3", post_status: 1, tone: "relaxed", emotion_id: 5, user: user_2)
u2_p4 = Post.create!(description: "This is the text for user 2 post 4", post_status: 1, tone: "relaxed", emotion_id: 7, user: user_2)

u3_p1 = Post.create!(description: "This is the text for user 3 post 1", post_status: 1, tone: "quizzical", emotion_id: 6, user: user_3)
u3_p2 = Post.create!(description: "This is the text for user 3 post 2", post_status: 0, tone: "frustrated", emotion_id: 7, user: user_3)
u3_p3 = Post.create!(description: "This is the text for user 3 post 3", post_status: 1, tone: "psychotic", emotion_id: 8, user: user_3)
u3_p4 = Post.create!(description: "This is the text for user 3 post 4", post_status: 1, tone: "lazy", emotion_id: 9, user: user_3)

u4_p1 = Post.create!(description: "This is the text for user 4 post 1", post_status: 1, tone: "quizzical", emotion_id: 10, user: user_4)
u4_p2 = Post.create!(description: "This is the text for user 4 post 2", post_status: 0, tone: "frustrated", emotion_id: 11, user: user_4)
u4_p3 = Post.create!(description: "This is the text for user 4 post 3", post_status: 0, tone: "psychotic", emotion_id: 12, user: user_4)
u4_p4 = Post.create!(description: "This is the text for user 4 post 4", post_status: 1, tone: "lazy", emotion_id: 13, user: user_4)

u5_p1 = Post.create!(description: "This is the text for user 5 post 1", post_status: 1, tone: "eager", emotion_id: 14, user: user_5)
u5_p2 = Post.create!(description: "This is the text for user 5 post 2", post_status: 0, tone: "rushed", emotion_id: 15, user: user_5)
u5_p3 = Post.create!(description: "This is the text for user 5 post 3", post_status: 0, tone: "banana", emotion_id: 16, user: user_5)
u5_p4 = Post.create!(description: "This is the text for user 5 post 4", post_status: 1, tone: "melancholy", emotion_id: 17, user: user_5)

u6_p1 = Post.create!(description: "This is the text for user 6 post 1", post_status: 1, tone: "randy", emotion_id: 17, user: user_6)
u6_p2 = Post.create!(description: "This is the text for user 6 post 2", post_status: 0, tone: "energetic", emotion_id: 18, user: user_6)
u6_p3 = Post.create!(description: "This is the text for user 6 post 3", post_status: 0, tone: "scared", emotion_id: 19, user: user_6)
u6_p4 = Post.create!(description: "This is the text for user 6 post 4", post_status: 0, tone: "scary", emotion_id: 20, user: user_6)

u7_p1 = Post.create!(description: "This is the text for user 7 post 1", post_status: 1, tone: "happy", emotion_id: 21, user: user_7)
u7_p2 = Post.create!(description: "This is the text for user 7 post 2", post_status: 1, tone: "relaxed", emotion_id: 22, user: user_7)
u7_p3 = Post.create!(description: "This is the text for user 7 post 3", post_status: 0, tone: "frustrated", emotion_id: 1, user: user_7)
u7_p4 = Post.create!(description: "This is the text for user 7 post 4", post_status: 0, tone: "eager", emotion_id: 23, user: user_7)
u7_p5 = Post.create!(description: "This is the text for user 7 post 5", post_status: 0, tone: "underwhelmed", emotion_id: 24, user: user_7)

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

