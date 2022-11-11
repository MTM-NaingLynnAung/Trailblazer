module Keyword::Operation
  class Update < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Keyword, :find_by)
      step Contract::Build(constant: Keyword::Contract::Update)
    end
    step Subprocess(Present)
    step Contract::Validate(key: :keyword)
    step Contract::Persist()
  end
end
