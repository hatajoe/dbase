class CreateIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :issues do |t|
      t.references :milestone
      t.integer :number
      t.string :html_url
      t.string :state
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
