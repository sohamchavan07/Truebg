class Organization < ApplicationRecord
  has_many :verification_cases, dependent: :destroy
  has_many :candidates, through: :verification_cases

  validates :name, presence: true
end
