module Post::Operation
  class Search < Trailblazer::Operation
    step :search_posts!

    def search_posts!(options, params:, **)
      if options['current_user'].user_type == 'Admin'
        options[:model] = Post.where("title LIKE :search or description LIKE :search", search: "%#{params[:search_keyword]}%").order('updated_at DESC')
      else
        post = Post.where(user_id: options[:current_user].id).or(Post.where(privacy: 'TRUE')).order('updated_at DESC')
        options[:model] = post.where("title LIKE :search or description LIKE :search", search: "%#{params[:search_keyword]}%").order('updated_at DESC')
      end
      options[:last_search_keyword] = params[:search_keyword]
    end
  end
end
