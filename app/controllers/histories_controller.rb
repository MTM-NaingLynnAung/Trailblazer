class HistoriesController < ApplicationController
  def destroy
    run History::Operation::Destroy do |result|
      redirect_to post_path(result[:model][:post_id]), notice: 'History deleted successfully'
    end
  end
end
