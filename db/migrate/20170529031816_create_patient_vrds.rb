class CreatePatientVrds < ActiveRecord::Migration[5.0]
  def change
    create_table :patient_vrds do |t|
      t.integer :patient_profile_id
      t.date :dates
      t.text :location
      t.text :o2level
      t.text :heartrate
      t.text :headposition
      t.text :headrotation

      t.timestamps
    end
  end
end
