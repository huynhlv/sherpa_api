class AdvertiserAccount < ApplicationRecord
  belongs_to :user

  validates :email, presence: true, uniqueness: {case_sensitive: false}
end
