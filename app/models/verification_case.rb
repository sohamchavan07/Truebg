class VerificationCase < ApplicationRecord
  belongs_to :candidate
  belongs_to :organization

  before_create :generate_token

  STATUSES = %w[draft sent in_progress completed cancelled].freeze
  validates :status, inclusion: { in: STATUSES }

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64(32)
  end
end
