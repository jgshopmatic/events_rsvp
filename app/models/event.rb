class Event < ApplicationRecord
  has_many :invitations, dependent: :destroy
  enum status: {
    coming_up: 0,
    in_progress: 1,
    completed: 2
  }

  scope :status, -> (status) { status.blank? ? all : where(status: status.to_sym) }

end
