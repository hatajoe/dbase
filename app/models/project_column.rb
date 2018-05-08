class ProjectColumn < ApplicationRecord
  belongs_to :project
  has_many :project_cards, dependent: :destroy
end
