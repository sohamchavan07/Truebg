class AddConsentToVerificationCases < ActiveRecord::Migration[8.0]
  def change
    add_column :verification_cases, :consent_given, :boolean
    add_column :verification_cases, :consent_given_at, :datetime
    add_column :verification_cases, :consent_ip_address, :string
    add_column :verification_cases, :signature_text, :string
  end
end
