class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.integer :mender_id
      t.integer :post_id
      t.timestamps
    end
  end
end
