require 'sidekiq-scheduler'
class DeletePostJob < ApplicationJob
  queue_as :default

  def perform(*args)
    posts = Post.all
    title_keyword = []
    posts.each do |post|
      title_keyword << post.title
    end
    ban_keyword = Keyword.where(name: title_keyword)
    post_title = []
    ban_keyword.each do |keyword|
      post_title << keyword.name
    end
    posts = Post.where(title: post_title)
    users_id = []
    posts.each do |post|
      users_id << post.user_id
    end
    users = User.where(id: users_id)
    users.each do |user|
      DeleteMailer.with(email: user.email).delete.deliver_now
    end
    if posts.present?
      posts.each do |post|
        post.destroy
      end
    end
  end
end
