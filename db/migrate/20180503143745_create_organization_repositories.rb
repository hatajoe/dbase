class CreateOrganizationRepositories < ActiveRecord::Migration[5.1]
  def change
    create_table :organization_repositories do |t|
      t.references :organization, foreign_key: true
      t.references :repository, foreign_key: true

      t.timestamps
    end
    add_index :organization_repositories, %i[organization_id repository_id], unique: true, name: 'organization_repository_unique'
  end
end
