class AddSessionDigestToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :session_digest, :string
  end
end
