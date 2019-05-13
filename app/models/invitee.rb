class Invitee < ApplicationRecord
  belongs_to :event, inverse_of: :invitees
  has_one :user
end
