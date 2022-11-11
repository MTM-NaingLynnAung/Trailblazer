module Post::Operation
  class Filter < Trailblazer::Operation
    step :filter_posts!

    def filter_posts!(options, params:, **)
      case params[:filter]
      when 'All'
        if options[:current_user][:user_type] == 'Admin'
          options[:model] = Post.all.order('updated_at DESC')
        else
          options[:model] = Post.where(user_id: options[:current_user].id).or(Post.where(privacy: 'TRUE')).order('updated_at DESC')
        end
      when 'Other Posts'
        if options[:current_user][:user_type] == 'Admin'
          options[:model] = Post.where.not(user_id: options[:current_user][:id]).order('updated_at DESC')
        else
          options[:model] = Post.where.not(user_id: options[:current_user][:id]).where(privacy: 'TRUE').order('updated_at DESC')
        end
      when 'My Posts'
        options[:model] = Post.where(user_id: options[:current_user][:id]).order('updated_at DESC')
      end
      options[:last_filter] = params[:filter]
    end
  end
end
