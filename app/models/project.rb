class Project < ApplicationRecord
  belongs_to :repository
  has_many :project_columns, dependent: :destroy
end
