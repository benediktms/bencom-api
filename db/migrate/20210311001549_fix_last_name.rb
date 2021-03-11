class FixLastName < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :lastname, :last_name
  end
end
