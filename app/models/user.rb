class User < ApplicationRecord
  has_many :invitations, dependent: :destroy
end
