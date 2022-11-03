module Post::Operation
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Post, :new)
      step Contract::Build(constant: Post::Contract::Create)
    end
    step Nested(Present)
    step :current_user!
    step Contract::Validate(key: :post)
    step :check_character!
    step Contract::Persist()
    step :create_image

    def current_user!(options, **)
      options[:params][:post][:user_id] = options['current_user'][:id]
    end

    def check_character!(options, params:, **)
      ban_keyword = Keyword.where(name: params[:post][:title].gsub(Constants::REMOVE_SPECIAL_CHARACTER, ''))
                           .or(Keyword.where(name: params[:post][:description].gsub(Constants::REMOVE_SPECIAL_CHARACTER, '')))
      if ban_keyword.empty?
        true
      end
    end

    def create_image(options, params:, **)
      if params[:post][:image].present?
        params[:post][:image].each do |image| 
          options['post_image'] = options[:model].post_attachments.create!(:image => image)
        end
      end 
    end
  end
end
