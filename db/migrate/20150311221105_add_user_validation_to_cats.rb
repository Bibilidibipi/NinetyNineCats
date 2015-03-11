class AddUserValidationToCats < ActiveRecord::Migration
  def change
    change_column :cats, :user_id, :integer, null: false,
                                             index: true,
                                             references: :users
  end
end
