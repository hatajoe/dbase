class Milestone < ApplicationRecord
  belongs_to :repository
  has_many :issues, dependent: :destroy
end
