class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :category_id, null: false
      t.string  :title, null: false
      t.text    :body, null: false
      t.integer :rating, null: false

      t.timestamps
    end

    add_index :posts, :user_id
    add_index :posts, :category_id
  end
end