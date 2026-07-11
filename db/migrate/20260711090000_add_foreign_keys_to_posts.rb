class AddForeignKeysToPosts < ActiveRecord::Migration[8.0]
  def change
    unless foreign_key_exists?(:posts, :users, column: :user_id)
      add_foreign_key :posts, :users, column: :user_id
    end

    unless foreign_key_exists?(:posts, :categories, column: :category_id)
      add_foreign_key :posts, :categories, column: :category_id
    end
  end
end
