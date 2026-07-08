class AddEncryptedPasswordToUsers < ActiveRecord::Migration[7.1]
  def change
    if ActiveRecord::Base.connection_db_config.name == "primary"
      add_column :users, :encrypted_password, :string
    end
  end
end