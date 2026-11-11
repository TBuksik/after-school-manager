class Student < ApplicationRecord
  has_many :enrollments, dependent: :restrict_with_error
  has_many :groups, through: :enrollments

  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
