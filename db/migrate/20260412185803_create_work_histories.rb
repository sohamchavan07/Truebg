class CreateWorkHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :work_histories do |t|
      t.references :candidate, null: false, foreign_key: true
      t.string :company_name
      t.string :job_title
      t.date :start_date
      t.date :end_date
      t.boolean :current_job
      t.string :location
      t.text :description
      t.boolean :verified

      t.timestamps
    end
  end
end
