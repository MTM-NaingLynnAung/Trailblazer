require 'rails_helper'

RSpec.describe "Posts", type: :request do
  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)
  end

  let(:post_params) {
    {
      title: 'post title',
      description: 'post description',
      privacy: true,
      user_id: current_user.id
    }
  }

  let(:invalid_params) {
    {
      title: '',
      description: '',
      privacy: ''
    }
  }

  # Post List
  context "GET /posts" do
    it "get post list" do
      get posts_path
      expect(response).to have_http_status(200)
    end
  end

  # Create Post
  context "POST /posts/new" do
    it "Valid values for create post" do
      post "/posts", params: { post: post_params }
      expect(flash[:notice]).to eq('Post created successfully')
    end

    it 'Fail values for create post' do
      post "/posts", params: { post: invalid_params }
      expect(response).to have_http_status(422)
      expect(response).to render_template(:new)
    end

    it 'post can\'t create with ban keyword' do
      post_params[:title] = "mad ask"
      post_params[:description] = "love"
      post '/posts', params: { post: post_params }
      expect(flash[:alert]).to eq('Failed to create post')
      expect(response).to have_http_status(422)
      expect(response).to render_template(:new)
    end
  end

  # Post Details
  context 'GET /posts/:id' do
    it "Post Details" do
      post = Post.create(post_params)
      get "/posts/#{post.id}"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end

  # Post Update
  context 'PATCH /posts/:id/edit' do
    it 'Valid values for Post Update' do
      post = Post.create(post_params)
      patch "/posts/#{post.id}", params: { post: post_params }
      expect(flash[:notice]).to eq('Post updated successfully')
    end

    it "Fail values for Post Update" do
      post = Post.create(post_params)
      patch "/posts/#{post.id}", params: { post: invalid_params }
      expect(response).to have_http_status(422)
      expect(response).to render_template(:edit)
    end
  end

  # Post Delete
  context 'Delete /posts/:id' do
    it 'Delete post' do
      post = Post.create(post_params)
      delete "/posts/#{post.id}"
      expect(flash[:notice]).to eq('Post deleted successfully')
    end
  end

  # Post Filter
  context 'GET /posts/filter' do
    it 'filter all posts' do
      get '/posts/filter', params: { filter: 'All' }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

    it 'filtering posts by created user' do
      get '/posts/filter', params: { filter: 'My Posts' }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

    it 'filtering posts by other user' do
      get '/posts/filter', params: { filter: 'Other Posts' }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  # Search posts
  context 'GET /posts/search' do
    it 'seach posts' do
      post = Post.create(post_params)
      get '/posts/search', params: { search_keyword: 'post' }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  # Post csv export
  context 'GET /posts/export' do
    it 'post list csv export' do
      Post.create(post_params)
      get export_posts_path, params: { format: :csv }
      expect(response).to have_http_status(200)
      expect(response.body).to include('post title')
    end
  end

  # Post csv import
  context 'POST /posts/import' do
    it 'post csv import with valid data' do
      post "/posts/import", params: { file: fixture_file_upload("#{Rails.root}/spec/import_valid.csv", "text/csv") }
      post = Post.last
      expect(flash[:notice]).to eq("Import CSV successfully")
      expect(post.title).to eq("lo.ves")
    end

    it 'post csv import with invalid data' do
      post "/posts/import", params: { file: fixture_file_upload("#{Rails.root}/spec/import_invalid.csv", "text/csv") }
      expect(response).to have_http_status(422)
      expect(response).to render_template(:import)
    end
  end
end
