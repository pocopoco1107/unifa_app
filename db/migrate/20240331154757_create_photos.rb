class CreatePhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :photos do |t|
      t.text :title, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :photos, [:user_id, :created_at]
  end
end
