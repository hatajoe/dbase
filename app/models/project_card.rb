class ProjectCard < ApplicationRecord
  belongs_to :project_column
  has_one :issue, primary_key: :issue_id, foreign_key: :number

  def note
    (issue.try(:title) || read_attribute(:note)).to_s
  end
end
