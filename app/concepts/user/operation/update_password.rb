module User::Operation
  class UpdatePassword < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step :model!
      step Contract::Build(constant: User::Contract::UpdatePassword)

      def model!(options, **)
        options['model'] = User.find(options['user_id'])
      end
    end
    step Subprocess(Present)
    step Contract::Validate(key: :user)
    step Contract::Persist()
  end
end
