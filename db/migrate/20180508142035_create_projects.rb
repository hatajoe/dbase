class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :repository_name
      t.integer :number
      t.string :owner_url
      t.string :html_url
      t.string :state
      t.string :name
      t.text :body

      t.timestamps
    end
  end
end
