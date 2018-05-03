class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :uid
      t.string :name

      t.timestamps
    end
    add_index :organizations, :uid, unique: true
  end
end
