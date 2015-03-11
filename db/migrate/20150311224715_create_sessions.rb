class CreateSessions < ActiveRecord::Migration
  def up
    create_table :sessions do |t|
      t.references :user, index: true, null: false
      t.string :session_token, unique: true, null: false
    end
    add_foreign_key :sessions, :users

    remove_column :users, :session_token
  end

  def down
    remove_table :sessions
    add_column :users, :session_token, null: false
  end
end
