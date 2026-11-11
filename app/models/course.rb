class Course < ApplicationRecord
  has_many :groups, dependent: :restrict_with_error

  validates :name, presence: true
end
