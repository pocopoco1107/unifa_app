class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :code
      t.string :password_digest

      t.timestamps
    end
    add_index :users, :code, unique: true
  end
end
