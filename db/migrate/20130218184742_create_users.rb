class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :remember_token

      t.timestamps
    end

    add_index :users, :user_name, unique: true
    add_index :users, :remember_token, unique: true
  end
end
