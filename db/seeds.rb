# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Genre.create([
  { soup: "醤油" },
  { soup: "味噌" },
  { soup: "塩" },
  { soup: "豚骨" }
])

members = Member.create([
  {last_name: "ゲスト",first_name: "お試し",is_active: "true",email: "guest_user@example.com",password: "aa12345bb"},
  {last_name: "博文",first_name: "伊藤",is_active: "true",email: "user1@example.com",password: "aa12345bb"},
  {last_name: "重信",first_name: "大隈",is_active: "true",email: "user2@example.com",password: "bb12345cc"},
  {last_name: "公望",first_name: "西園寺",is_active: "true",email: "user3@example.com",password: "cc12345dd"}
])

Post.create([
  {
    title: "醤油ラーメン",body: "客野製麺さんの濃い口醤油ラーメンです。",star: 4,
    image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"),filename:"sample-post1.jpg"),member_id: members[1].id
  },
  {
    title: "豚骨ラーメン",body: "一世風靡さんの豚骨ラーメンです。",star: 3.5,
    image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"),filename:"sample-post2.jpg"),member_id: members[2].id
  },
  {
    title: "味噌ラーメン",body: "らぁめん秀さんの味玉味噌ラーメンです。",star: 3,
    image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"),filename:"sample-post3.jpg"),member_id: members[3].id
  },
  {
    title: "塩ラーメン",body: "麺屋ITUKIさんの黒潮ラーメンです。",star: 4.5,
    image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post4.jpg"),filename:"sample-post4.jpg"),member_id: members[1].id
  },
  {
    title: "博多豚骨ラーメン",body: "ラーメン虎龍さんの久留米ラーメンです。",star: 4.5,
    image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post5.jpg"),filename:"sample-post5.jpg"),member_id: members[2].id
  },
  {
    title: "醤油豚骨ラーメン",body: "麺屋福座さんの福座ラーメンです。",star: 4.0,
    image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post6.jpg"),filename:"sample-post6.jpg"),member_id: members[3].id
  },
])


PostGenre.create([
    {post_id: 1,genre_id: 1},
    {post_id: 2,genre_id: 4},
    {post_id: 3,genre_id: 2},
    {post_id: 4,genre_id: 3},
    {post_id: 5,genre_id: 4},
    {post_id: 6,genre_id: 1}
  ])
