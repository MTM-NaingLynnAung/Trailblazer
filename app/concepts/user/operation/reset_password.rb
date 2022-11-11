module User::Operation
  class ResetPassword < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step :model!
      step Contract::Build(constant: User::Contract::ResetPassword)

      def model!(options, params:, **)
        options['model'] = User.find_signed!(params['token'], purpose: 'password_reset')
        rescue ActiveSupport::MessageVerifier::InvalidSignature
      end
    end
    step Subprocess(Present)
    step Contract::Validate(key: :user)
    step Contract::Persist()

  end
end
