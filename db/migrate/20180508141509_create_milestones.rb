class CreateMilestones < ActiveRecord::Migration[5.1]
  def change
    create_table :milestones do |t|
      t.references :repository, foreign_key: true
      t.integer :number
      t.string :title
      t.text :description
      t.string :url
      t.string :state
      t.integer :open_issues
      t.integer :closed_issues
      t.datetime :due_on

      t.timestamps
    end
  end
end
