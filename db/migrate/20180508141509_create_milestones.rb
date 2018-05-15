class CreateMilestones < ActiveRecord::Migration[5.1]
  def change
    create_table :milestones do |t|
      t.string :repository_name
      t.integer :number
      t.string :title
      t.text :description
      t.string :html_url
      t.string :state
      t.integer :open_issues
      t.integer :closed_issues
      t.datetime :due_on

      t.timestamps
    end
  end
end
