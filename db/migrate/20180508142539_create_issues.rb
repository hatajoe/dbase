class CreateIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :issues do |t|
      t.references :milestone, foreign_key: true
      t.integer :number
      t.string :url
      t.string :state
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
