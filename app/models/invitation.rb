class Invitation < ApplicationRecord
  belongs_to :event, inverse_of: :invitations
  belongs_to :user, inverse_of: :invitations
end
