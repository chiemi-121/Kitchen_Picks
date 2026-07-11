class AddForeignKeysToPosts < ActiveRecord::Migration[8.0]
  def change
    ensure_bigint_column(:posts, :user_id)
    ensure_bigint_column(:posts, :category_id)

    unless foreign_key_exists?(:posts, :users, column: :user_id)
      add_foreign_key :posts, :users, column: :user_id
    end

    unless foreign_key_exists?(:posts, :categories, column: :category_id)
      add_foreign_key :posts, :categories, column: :category_id
    end
  end

  private

  def ensure_bigint_column(table, column)
    current = connection.columns(table).find { |c| c.name == column.to_s }
    return if current&.type == :bigint

    change_column table, column, :bigint, null: false
  end
end
