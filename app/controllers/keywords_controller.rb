class KeywordsController < ApplicationController
  before_action :admin?, only: [:new, :create, :destroy, :edit, :update]
  def index
    run Keyword::Operation::Index
  end

  def new
    run Keyword::Operation::Create::Present
  end

  def create
    run Keyword::Operation::Create do |result|
      return redirect_to keywords_path, notice: 'Keyword created successfully'
    end
    flash[:alert] = 'Failed to create keyword'
    render :new
  end

  def edit
    run Keyword::Operation::Update::Present
  end

  def update
    run Keyword::Operation::Update do |result|
      return redirect_to keywords_path, notice: 'Keyword updated successfully'
    end
    flash[:alert] = 'Failed to update keyword'
    render :edit
  end

  def destroy
    run Keyword::Operation::Destroy do |result|
      redirect_to keywords_path, notice: 'Keyword deleted successfully'
    end
  end
end
