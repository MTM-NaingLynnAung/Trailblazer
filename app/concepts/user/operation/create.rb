module User::Operation
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(User, :new)
      step Contract::Build(constact: User::Contract::Create)
    end
    step Nested(Present)
    step :set_current_user
    step Contract::Validate(key: :user)
    step Contract::Persist()

    def set_current_user(options, **)
      options[:params][:user][:id] = options['current_user'][:id]
    end
  end
end
