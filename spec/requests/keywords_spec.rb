require 'rails_helper'

RSpec.describe "Keywords", type: :request do
  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)
  end

  let(:keyword_params){
    {
      name: "test"
    }
  }

  let(:invalid_params){
    {
      name: ''
    }
  }
  # Keywords List
  context "GET /keywords" do
    it "get keywords list" do
      get keywords_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  # Keyword Create
  context "POST /keywords/new" do
    it "create keywords with valid data" do
      post "/keywords", params: { keyword: keyword_params }
      expect(flash[:notice]).to eq("Keyword created successfully")
    end

    it "create keywords with invalid data" do
      post "/keywords", params: { keyword: invalid_params }
      expect(response).to have_http_status(422)
      expect(response).to render_template(:new)
    end

    it "can't create with existing keywords" do
      keyword_params[:name] = "ask"
      post "/keywords", params: { keyword: keyword_params }
      expect(response).to have_http_status(422)
      expect(response).to render_template(:new)
    end
  end

  # Keywords Update
  context "PATCH /keywords/:id/edit" do
    it 'Valid keywords to update' do
      keyword = Keyword.last
      keyword_params[:name] = 'update'
      patch "/keywords/#{keyword.id}", params: { keyword: keyword_params }
      expect(flash[:notice]).to eq("Keyword updated successfully")
    end

    it "Invalid keywords to update" do
      keyword = Keyword.last
      patch "/keywords/#{keyword.id}", params: { keyword: invalid_params }
      expect(response).to have_http_status(422)
      expect(response).to render_template(:edit)
    end
  end

  # Delete Keyword
  context "DELETE /keywords/:id" do
    it "delete keyword" do
      keyword = Keyword.last
      delete "/keywords/#{keyword.id}"
      expect(flash[:notice]).to eq("Keyword deleted successfully")
    end
  end
end
