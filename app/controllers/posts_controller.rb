class PostsController < ApplicationController
  def index
    run Post::Operation::Index do |result|
      @model = result[:posts]
    end
  end

  def new
    run Post::Operation::Create::Present
  end

  def create
    run Post::Operation::Create, current_user: current_user do |result|
      return redirect_to posts_path, notice: 'Post created successfully'
    end
    flash[:alert] = 'Failed to create post'
    render :new, status: :unprocessable_entity
  end

  def show
    run Post::Operation::Show
    return result[:model]
  end

  def edit
    run Post::Operation::Update::Present
  end

  def update
    run Post::Operation::Update, current_user: current_user do |result|
      return redirect_to post_path, notice: 'Post updated successfully'
    end
    flash[:alert] = 'Failed to update post'
    render :edit, status: :unprocessable_entity
  end

  def destroy
    run Post::Operation::Destroy do |result|
      redirect_to posts_path, notice: 'Post deleted successfully'
    end
  end

  def search
    run Post::Operation::Search do |result|
      @last_search_keyword = result[:last_search_keyword]
      render :index
      return
    end
  end
end
