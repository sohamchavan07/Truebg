class CreateEducationHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :education_histories do |t|
      t.references :candidate, null: false, foreign_key: true
      t.string :institution_name
      t.string :degree
      t.string :field_of_study
      t.integer :graduation_year
      t.boolean :verified

      t.timestamps
    end
  end
end
