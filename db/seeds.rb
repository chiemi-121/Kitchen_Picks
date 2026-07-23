# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
categories = [
  "時短",
  "収納",
  "調理",
  "片付け"
]

category_fallbacks = {
  "100均" => "収納",
  "調理器具" => "調理",
  "お手入れ" => "片付け"
}

category_fallbacks.each do |old_name, new_name|
  old_category = Category.find_by(name: old_name)
  new_category = Category.find_or_create_by!(name: new_name)

  next unless old_category

  Post.where(category_id: old_category.id).update_all(category_id: new_category.id)
end

Category.where.not(name: categories).where.not(id: Post.select(:category_id)).find_each(&:destroy)

categories.each do |name|
  Category.find_or_create_by!(name: name)
end

tags = [
  "電子レンジ",
  "パスタ",
  "朝ごはん",
  "お弁当",
  "子育て向け",
  "洗い物が減る",
  "100均",
  "便利グッズ",
  "コスパ",
  "省スペース",
  "収納ボックス",
  "仕切り・トレー",
  "冷蔵庫収納",
  "調味料収納",
  "フライパン",
  "鍋",
  "包丁",
  "まな板",
  "調理器具",
  "ボウル",
  "計量ツール",
  "お菓子作り",
  "食洗機対応",
  "掃除グッズ",
  "水回り便利グッズ"
]

# seeds の配列を正として、配列外の旧タグを削除する
Tag.where.not(name: tags).find_each(&:destroy)

tags.each do |name|
  Tag.find_or_create_by!(name: name)
end

admin_login_id = ENV.fetch("ADMIN_LOGIN_ID", "admin")
admin_email = ENV.fetch("ADMIN_EMAIL", "admin@example.com")
admin_password = ENV.fetch("ADMIN_PASSWORD", "password")

admin = Admin.find_or_create_by!(login_id: admin_login_id) do |record|
  record.email = admin_email
  record.password = admin_password
  record.password_confirmation = admin_password
end

admin.update!(
  email: admin_email,
  password: admin_password,
  password_confirmation: admin_password
)