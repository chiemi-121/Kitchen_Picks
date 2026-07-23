require "securerandom"
require "json"
require "fileutils"

namespace :posts do
  desc "Export posts with categories and tags to a JSON file"
  task :export, [:path] => :environment do |_, args|
    path = args[:path].presence || "tmp/posts_export.json"
    FileUtils.mkdir_p(File.dirname(path))

    payload = {
      exported_at: Time.current.iso8601,
      posts: Post.with_attached_images.includes(:user, :category, :tags).order(created_at: :asc).map do |post|
        {
          title: post.title,
          body: post.body,
          rating: post.rating,
          user_name: post.user.name,
          user_email: post.user.email,
          category_name: post.category&.name,
          tag_names: post.tags.pluck(:name),
          image_filenames: post.images.map { |image| image.filename.to_s },
          created_at: post.created_at&.iso8601,
          updated_at: post.updated_at&.iso8601
        }
      end
    }

    File.write(path, JSON.pretty_generate(payload))
    puts "Exported #{payload[:posts].size} posts to #{path}"
  end

  desc "Import posts from a JSON file exported by posts:export"
  task :import, [:path] => :environment do |_, args|
    path = args[:path].presence || raise(ArgumentError, "path is required. Example: bin/rails posts:import[tmp/posts_export.json]")
    unless File.exist?(path)
      raise ArgumentError, "File not found: #{path}"
    end

    data = JSON.parse(File.read(path))
    posts = Array(data["posts"])

    posts.each do |row|
      user = User.find_or_create_by!(email: row["user_email"]) do |record|
        record.name = row["user_name"].presence || row["user_email"].to_s.split("@").first
        record.password = SecureRandom.hex(16)
        record.password_confirmation = record.password
      end

      category_name = row["category_name"].to_s
      raise ActiveRecord::RecordNotFound, "Category not found: #{category_name}" if category_name.blank?

      category = Category.find_or_create_by!(name: category_name)
      post = Post.find_or_initialize_by(title: row["title"], user: user)
      post.body = row["body"]
      post.rating = row["rating"]
      post.category = category
      post.save!

      tag_names = Array(row["tag_names"]).compact.map(&:to_s).reject(&:blank?)
      tags = tag_names.map { |name| Tag.find_or_create_by!(name: name) }
      post.tags = tags

      puts "Imported: #{post.title}"
    end

    puts "Imported #{posts.size} posts from #{path}"
  end
end