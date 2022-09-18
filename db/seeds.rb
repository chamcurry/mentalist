# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Genre.create([
  { soup: '醤油' },
  { soup: '味噌' },
  { soup: '塩' },
  { soup: '豚骨' }
])

menbers = Menber.create!([
  {last_name: 'ゲスト',first_name: 'お試し',is_active: 'false',email: 'guest_user@example.com',password: 'aa12345bb'},
  {last_name: '博文',first_name: '伊藤',is_active: 'false',email: 'user1@example.com',password: 'aa12345bb'},
  {last_name: '重信',first_name: '大隈',is_active: 'false',email: 'user2@example.com',password: 'bb12345cc'},
  {last_name: '公望',first_name: '西園寺',is_active: 'false',email: 'user3@example.com',password: 'cc12345dd'}
])

Post.create!([
  {
    title: '醤油ラーメン',body: '客野製麺さんの濃い口醤油ラーメンです。',star: 4,
    image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"),filename:"sample-post1.jpg"),menber_id: menbers[1].id
  },
  {
    title: '豚骨ラーメン',body: '魂心家さんの魂心ラーメンです。',star: 3.5,
    image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"),filename:"sample-post2.jpg"),menber_id: menbers[2].id
  },
  {
    title: '味噌ラーメン',body: 'らぁめん秀さんの味玉味噌ラーメンです。',star: 3,
    image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"),filename:"sample-post3.jpg"),menber_id: menbers[3].id
  }
])