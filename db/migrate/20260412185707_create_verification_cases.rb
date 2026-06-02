class CreateVerificationCases < ActiveRecord::Migration[8.0]
  def change
    create_table :verification_cases do |t|
      t.references :candidate, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true
      t.string :status
      t.string :token
      t.datetime :requested_at
      t.datetime :completed_at

      t.timestamps
    end
    add_index :verification_cases, :token
  end
end
