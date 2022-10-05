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
    run User::Operation::Create do |result|
      return redirect_to users_path, notice: 'User created successfully'
    end
    flash[:alert] = 'Failed to create user'
    render :new, status: :unprocessable_entity
  end

  def show
    run User::Operation::Show
    return result[:model]
  end

  def edit
    run User::Operation::Update::Present
    return result[:model]
  end

  def update
    run User::Operation::Update do |result|
      return redirect_to users_path, notice: 'User updated successfully'
    end
    flash[:alert] = 'Failed to update user'
    render :edit, status: :unprocessable_entity
  end

  def destroy
    run User::Operation::Destroy do |result|
      return redirect_to users_path, notice: 'User deleted successfully'
    end
  end
end
