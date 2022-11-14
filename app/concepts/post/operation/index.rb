module Post::Operation
  class Index < Trailblazer::Operation
    step :get_post_list

    def get_post_list(options, **)
      schedule_post = Post.where.not(public_schedule: nil).or(Post.where.not(private_schedule: nil))
      schedule_post.each do |post|
        if post.public_schedule.present? && Time.now >= post.public_schedule
          post.privacy = true
        elsif post.private_schedule.present? && Time.now >= post.private_schedule
          post.privacy = false
        end
          post.save!
      end
      if options[:current_user].user_type == "User"
        options[:model] = Post.where(user_id: options[:current_user].id).or(Post.where(privacy: 'TRUE')).order('updated_at DESC')
      else
        options[:model] = Post.all.order('updated_at DESC')
      end
      
    end
  end
end
