class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :uid
      t.string :name
      t.string :encrypted_github_api_token
      t.string :encrypted_github_api_token_iv

      t.timestamps
    end
    add_index :organizations, :uid, unique: true
  end
end
