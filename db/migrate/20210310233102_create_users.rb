class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :lastname
      t.string :email, null: true
      t.string :password, null: true

      t.timestamps
    end
    add_index :users, :email
  end
end
