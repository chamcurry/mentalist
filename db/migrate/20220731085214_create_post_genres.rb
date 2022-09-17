class CreatePostGenres < ActiveRecord::Migration[6.0]
  def change
    create_table :post_genres do |t|
      t.integer :post_id
      t.integer :genre_id
      # t.references :post, null: false, foreign_key: true
      # t.references :genre, null: false, foreign_key: true
      t.timestamps
    end
    add_foreign_key :post_genres, :posts
    add_foreign_key :post_genres, :genres
  end
end
