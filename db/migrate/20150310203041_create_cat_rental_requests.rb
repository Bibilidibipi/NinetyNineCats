class CreateCatRentalRequests < ActiveRecord::Migration
  def change
    create_table :cat_rental_requests do |t|
      t.integer :cat_id, references: :cats, null: false, index: true
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :status, default: "PENDING", null: false

      t.timestamps null: false
    end
  end
end
