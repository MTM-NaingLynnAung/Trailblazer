require 'sidekiq-scheduler'
class NotifyJob < ApplicationJob
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
      NotifyMailer.with(email: user.email, post: posts.where(user_id: user.id)).notify.deliver_now
    end
  end

end