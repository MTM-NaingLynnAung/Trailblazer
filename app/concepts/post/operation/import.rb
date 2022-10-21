require 'csv'
module Post::Operation
  class Import < Trailblazer::Operation
    step Contract::Build(constant: Post::Contract::Import)
    step Contract::Validate()
    step :import_csv!

    def import_csv!(options, params:, **)
      file = File.open(params[:file])
      csv = CSV.parse(file, headers: true)
      begin
        csv.each do |row|
          post_hash = {}
          post_attach = {}
          post_hash[:title] = row["title"]
          post_hash[:description] = row["description"]
          if row["privacy"].downcase == "true"
            post_hash[:privacy] = 1
          else
            post_hash[:privacy] = 0
          end
          post_hash[:user_id] = options["current_user_id"]
          post_hash[:created_at] = Time.now
          post_hash[:updated_at] = Time.now
          @post = Post.create(post_hash)
          
          row["images"].split(/\s*,\s*/).each do |image|
            post_attach[:image] = File.open("#{Rails.root}#{image}")
            post_attach[:post_id] = @post.id
            post_attach[:created_at] = Time.now
            post_attach[:updated_at] = Time.now
            PostAttachment.create!(post_attach)
          end
        end
      rescue ActiveRecord::NotNullViolation => e
        print "Error : #{ e }"
      end
      
    end
  end
end
