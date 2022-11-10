require 'rails_helper'

RSpec.describe "Keywords", type: :request do
  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)
  end
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
      post "/keywords", params: { keyword: { name: "test" } }
      expect(flash[:notice]).to eq("Keyword created successfully")
    end

    it "create keywords with invalid data" do
      post "/keywords", params: { keyword: { name: "" } }
      expect(response).to have_http_status(422)
      expect(response).to render_template(:new)
    end

    it "create with existing keywords" do
      post "/keywords", params: { keyword: { name: "ask" } }
      expect(response).to have_http_status(422)
      expect(response).to render_template(:new)
    end
  end

  # Keywords Update
  context "PATCH /keywords/:id/edit" do
    it 'Valid keywords to update' do
      keyword = Keyword.last
      patch "/keywords/#{keyword.id}", params: { keyword: { name: 'update' } }
      expect(flash[:notice]).to eq("Keyword updated successfully")
    end

    it "Invalid keywords to update" do
      keyword = Keyword.last
      patch "/keywords/#{keyword.id}", params: { keyword: { name: '' } }
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
