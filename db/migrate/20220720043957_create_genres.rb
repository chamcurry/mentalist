class CreateGenres < ActiveRecord::Migration[5.0]
  def change
    create_table :genres do |t|
      t.string :soup
      t.string :noodle
      t.timestamps
    end
  end
end
