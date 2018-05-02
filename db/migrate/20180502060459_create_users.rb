class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :picture

      t.timestamps
    end
    add_index :users, :uid, unique: true
    add_index :users, %i[provider uid]
    add_index :users, :email, unique: true
  end
end
