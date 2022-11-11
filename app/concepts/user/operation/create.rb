module User::Operation
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(User, :new)
      step Contract::Build(constant: User::Contract::Create)
    end
    step Subprocess(Present)
    step :user_type!
    step Contract::Validate(key: :user)
    step Contract::Persist()

    def user_type!(options, params:, **)
      if options['current_user'].nil?
        params[:user][:user_type] = 'User'
      else
        true
      end
    end
  end
end
