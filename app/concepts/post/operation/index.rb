module Post::Operation
  class Index < Trailblazer::Operation
    step :get_post_list

    def get_post_list(options, **)
      if options[:current_user].user_type == "User"
        options[:model] = Post.where(user_id: options[:current_user].id).or(Post.where(privacy: 'TRUE')).order('id DESC')
      else
        options[:model] = Post.all.order('id DESC')
      end
    end
  end
end
