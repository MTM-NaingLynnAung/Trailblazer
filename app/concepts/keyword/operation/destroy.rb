module Keyword::Operation
  class Destroy < Trailblazer::Operation
    step Model(Keyword, :find_by)
    step :delete!

    def delete!(options, model:, **)
      model.destroy
    end
  end
end
