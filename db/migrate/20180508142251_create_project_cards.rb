class CreateProjectCards < ActiveRecord::Migration[5.1]
  def change
    create_table :project_cards do |t|
      t.references :project_column, foreign_key: true
      t.references :issue
      t.text :note
      t.string :content_url

      t.timestamps
    end
  end
end
