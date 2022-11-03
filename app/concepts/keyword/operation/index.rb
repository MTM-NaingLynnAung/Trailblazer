module Keyword::Operation
  class Index < Trailblazer::Operation
    step :get_keywords_list

    def get_keywords_list(options, **)
      options[:model] = Keyword.all.order('id DESC')
    end
  end
end
