class Chef < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :chefname, presence: true, length: {maximum: 30}
  VALID_EMAILS = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, presence: true, length: {maximum:255}, format: { with: VALID_EMAILS },
                              uniqueness: {case_sensitive: false}
                              
  has_many :recipes
end