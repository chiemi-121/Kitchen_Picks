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
  "キッチン家電",
  "お手入れ"
]

categories.each do |name|
  Category.find_or_create_by(name: name)
end

tags = [
  "電子レンジ",
  "パスタ",
  "調理器具",
  "100均",
  "便利グッズ",
  "洗い物が減る",
  "子育て向け",
  "時短アイテム",
  "収納グッズ",
  "キッチン家電",
  "料理初心者向け",
  "一人暮らし向け",
  "お弁当作り",
  "省スペース",
  "多機能アイテム",
  "ダイソー",
  "セリア",
  "ニトリ",
  "無印良品",
  "お掃除ラク",
  "油汚れ対策",
  "料理が楽しくなる",
  "片付けが楽になる"
]

tags.each do |name|
  Tag.find_or_create_by(name: name)
end