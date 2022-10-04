class UsersController < ApplicationController
  def index
    run User::Operation::Index do |result|
      @users = result[:users]
    end
  end

  def new
    run User::Operation::Create::Present
  end

  def create
    run User::Operation::Create, current_user: current_user do |result|
      return redirect_to users_path
    end
    render :new
  end

  def show
  end

  def edit
  end
end
