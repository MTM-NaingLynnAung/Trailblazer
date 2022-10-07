module Post::Operation
  class Index < Trailblazer::Operation
    step :get_post_list

    def get_post_list(options, **)
      options[:posts] = Post.all.order('id DESC')
    end
  end
end
