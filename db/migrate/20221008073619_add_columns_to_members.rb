class AddColumnsToMembers < ActiveRecord::Migration[6.0]
  def change
    add_column :members, :uid, :string
    add_column :members, :provider, :string
  end
end
