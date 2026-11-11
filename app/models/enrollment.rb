class Enrollment < ApplicationRecord
  belongs_to :student
  belongs_to :group

  enum :status, { active: 0, withdrawn: 1 }, validate: true

  validates :student_id, uniqueness: { scope: :group_id, conditions: -> { active } },
                         if: :active?
end
