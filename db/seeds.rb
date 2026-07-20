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
  "100均",
  "調理器具",
  "お手入れ"
]

categories.each do |name|
  Category.find_or_create_by!(name: name)
end

tags = [
  "電子レンジ",
  "調理器具",
  "100均",
  "便利グッズ",
  "時短アイテム",
  "料理初心者向け",
  "一人暮らし向け",
  "お弁当作り",
  "多機能アイテム",
  "ダイソー",
  "セリア",
  "料理が楽しくなる",
  "片付けが楽になる"
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