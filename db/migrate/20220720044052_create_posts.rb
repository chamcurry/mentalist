class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer :menber_id
      t.integer :genre_id
      t.string :title
      t.string :body
      t.string :star
      t.timestamps
    end
  end
end
