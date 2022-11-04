require 'sidekiq-scheduler'
class NotifyJob < ApplicationJob
  queue_as :default

  def perform(post_list)
    title_keyword = []
    post_list.each do |post|
      title_keyword << post.title
    end
    ban_keyword = Keyword.where(name: title_keyword)
    post_title = []
    ban_keyword.each do |keyword|
      post_title << keyword.name
    end
    post = Post.where(title: post_title)
    user = []
    post.each do |post|
      user << User.find_by(id: post.user_id)
    end
    user.each do |user|
      NotifyMailer.with(email: user.email).notify.deliver_later
    end
  end
end
