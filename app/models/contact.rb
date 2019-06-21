class Contact < ApplicationRecord
  validates :name,                      presence: true
  validates :company_name,              presence: true
  validates :email,                     presence: true
  validates :telephone,                 presence: true
  validates :address,                   presence: true
  validates :description,               presence: true
end
