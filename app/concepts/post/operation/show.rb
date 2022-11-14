module Post::Operation
  class Show < Trailblazer::Operation
    step Model(Post, :find_by)
    step :schedule_post

    def schedule_post(options, model:, **)
      if options[:model].public_schedule.present? && Time.now >= options[:model].public_schedule
        options[:model].privacy = true
      elsif options[:model].private_schedule.present? && Time.now >= options[:model].private_schedule
        options[:model].privacy = false
      end
        options[:model].save!
    end
  end
end
