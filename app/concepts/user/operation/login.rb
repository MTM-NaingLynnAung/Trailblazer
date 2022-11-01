module User::Operation
  class Login < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(User, :new)
      step Contract::Build(constant: User::Contract::Login)
    end
    step Nested(Present)
    step Contract::Validate(key: :user)
    step :model!

    def model!(options, params:, **)
      user = User.find_by(email: params[:user][:email])
      if user && user.authenticate(params[:user][:password])
        options['user'] = user
        true
      elsif user && !user.authenticate(params[:user][:password])
        options['failed_attempts'] = params[:user][:failed_attempts].to_i
        options['user'] = user
        false
      else
        options['email_pwd_fail'] = 'Login Fail'
        false
      end
    end
  end
end
