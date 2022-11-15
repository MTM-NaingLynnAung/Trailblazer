module Post::Operation
  class Update < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Post, :find_by)
      step Contract::Build(constant: Post::Contract::Update)
    end
    step Subprocess(Present)
    step Contract::Validate(key: :post)
    step :create_history
    step :check_character!
    step Contract::Persist()
    step :current_image!

    def create_history(options, params:, **)
      History.create!(
        title: options[:model][:title],
        description: options[:model][:description],
        privacy: options[:model][:privacy],
        public_schedule: options[:model][:public_schedule],
        private_schedule: options[:model][:private_schedule],
        post_id: options[:model][:id]
      )
    end

    def check_character!(options, params:, **)
      ban_keyword = Keyword.where(name: params[:post][:title].split)
                           .or(Keyword.where(name: params[:post][:description].split))
      if ban_keyword.empty?
        true
      end
    end

    def current_image!(options, params:, **)
      if params[:post][:image].present?
        @photo = PostAttachment.where(post_id: params[:id])
        @photo.each do |image|
          image.destroy
        end
        params[:post][:image].each do |img|
          options["post_image"] = options[:model].post_attachments.create!(:image => img)
        end
      else
        return true
      end
    end
  end
end
