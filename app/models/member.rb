class Member < ApplicationRecord
  belongs_to :c_event

  accepts_nested_attributes_for :c_event
  after_create :increment_member

  def increment_member
    self.c_event.update_attribute(:member, self.c_event.member)
  end
end
