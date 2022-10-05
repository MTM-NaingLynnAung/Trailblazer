module User::Operation
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(User, :new)
      step Contract::Build(constant: User::Contract::Create)
    end
    step Nested(Present)
    step Contract::Validate(key: :user)
    step Contract::Persist()

    # def assign_current_user!(options, **)
    #   options[:params][:user][:id] = options['current_user'][:id]
    # end
  end
end
