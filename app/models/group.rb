class Group < ApplicationRecord
  belongs_to :course
  has_many :enrollments, dependent: :restrict_with_error
  has_many :students, through: :enrollments

  validates :name, presence: true
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }
end
