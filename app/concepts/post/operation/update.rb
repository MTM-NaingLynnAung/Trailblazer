module Post::Operation
  class Update < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Post, :find_by)
      step Contract::Build(constant: Post::Contract::Update)
    end
    step Nested(Present)
    step Contract::Validate(key: :post)
    step Contract::Persist()
    step :current_image!

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
