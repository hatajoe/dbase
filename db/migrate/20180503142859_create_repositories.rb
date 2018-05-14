class CreateRepositories < ActiveRecord::Migration[5.1]
  def change
    create_table :repositories do |t|
      t.string :full_name
      t.string :url
      t.string :state

      t.timestamps
    end
  end
end
