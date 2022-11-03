module Keyword::Operation
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Keyword, :new)
      step Contract::Build(constant: Keyword::Contract::Create)
    end
    step Nested(Present)
    step Contract::Validate(key: :keyword)
    step Contract::Persist()
  end
end

