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
      post "/posts", params: { post: { title: '', description: '', privacy: '' } }
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
      patch "/posts/#{post.id}", params: { post: { title: 'update title', description: 'update description', privacy: false } }
      expect(flash[:notice]).to eq('Post updated successfully')
    end

    it "Fail values for Post Update" do
      post = Post.create(post_params)
      patch "/posts/#{post.id}", params: { post: { title: '', description: '', privacy: '' } }
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

end
