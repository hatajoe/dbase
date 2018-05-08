class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.references :repository, foreign_key: true
      t.integer :number
      t.string :url
      t.string :name
      t.text :body

      t.timestamps
    end
  end
end
