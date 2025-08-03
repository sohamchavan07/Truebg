# == Schema Information
#
# Table name: verifications
#
#  id                :bigint           not null, primary key
#  status            :string
#  verification_type :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_verifications_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Verification < ApplicationRecord
    belongs_to :user

    VERIFICATION_TYPES = %w[email phone id_document].freeze
    STATUSES = %w[pending approved rejected].freeze

    # Validations
    validates :verification_type, presence: true, length: { maximum: 255 }, inclusion: { in: VERIFICATION_TYPES }
    validates :status, inclusion: { in: STATUSES },  allow_nil: true
end
