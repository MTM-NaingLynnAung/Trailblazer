require 'csv'
module Post::Operation::Export
  class CsvData < Trailblazer::Operation
    step :get_posts
    step :to_csv!

    def get_posts(options, params:, **)
      if params[:search].present?
        options[:posts] = Post.where("title LIKE :search", search: "%#{params[:search]}%")
      else
        options[:posts] = Post.all.order('id DESC')
      end
    end

    def to_csv!(options, **)
      attributes = %w{ id title description privacy }
      options[:csv_text] = CSV.generate(headers: true) do |csv|
                              csv << attributes
                              options[:posts].each do |post|
                                csv << attributes.map{ |attr| post.send(attr) }
                              end
                            end
    end
  end

  class Format < Trailblazer::Operation
    step :get_csv_format!

    def get_csv_format!(options, **)
      attributes = ["title", "description", "privacy"]
      options[:csv_format] = CSV.generate(headers: true) do |csv|
                                csv << attributes
                              end
    end
  end
end
