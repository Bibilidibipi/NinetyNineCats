class AddColumnToCatRentalRequest < ActiveRecord::Migration
  def change
    add_column :cat_rental_requests, :user_id, :integer, index: true,
                                                         null: false,
                                                         references: :users
  end
end
