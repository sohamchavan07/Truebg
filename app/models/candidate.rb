class Candidate < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :verification_cases, dependent: :destroy
  has_many :work_histories, dependent: :destroy
  has_many :education_histories, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}".strip
  end
end
