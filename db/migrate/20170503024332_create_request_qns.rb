class CreateRequestQns < ActiveRecord::Migration[5.0]
  def change
    create_table :request_qns do |t|
      t.integer :authcons_id
      t.integer :fusers_id
      t.integer :status
      t.string :q_type
      t.string :q1
      t.string :q2
      t.string :q3
      t.string :q4
      t.string :q5
      t.string :q6
      t.string :q7
      t.string :q8
      t.string :q9
      t.string :detail

      t.timestamps
    end
  end
end
