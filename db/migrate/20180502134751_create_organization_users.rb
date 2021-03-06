class CreateOrganizationUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :organization_users do |t|
      t.references :user, foreign_key: true
      t.references :organization, foreign_key: true

      t.timestamps
    end
    add_index :organization_users, %i[user_id organization_id], unique: true, name: 'user_organization_unique'
  end
end
