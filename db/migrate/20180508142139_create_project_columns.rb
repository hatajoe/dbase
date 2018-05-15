class CreateProjectColumns < ActiveRecord::Migration[5.1]
  def change
    create_table :project_columns do |t|
      t.references :project, foreign_key: true
      t.string :name
      t.string :project_url

      t.timestamps
    end
  end
end
