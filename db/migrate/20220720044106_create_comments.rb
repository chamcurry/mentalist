class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :menber_id
      t.integer :post_id
      t.string :comment
      t.timestamps
    end
  end
end
