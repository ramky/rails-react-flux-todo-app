class Todo < ActiveRecord::Base
  validates_presence_of :name
  scope :completed, -> { where(completed: true) }
end
