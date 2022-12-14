require 'rails_helper'

RSpec.describe TopicsController, type: :controller do

  let(:topic){ Topic.create(title: 'Iron man', content:'Red man')}
  describe 'GET index' do
    context 'valid' do
      it 'Display topics' do
        get :index
        expect(assigns(:topics).count).to eq 0
        expect(assigns(:topics).find(topic.id)).to eq topic
        expect(response).to render_template 'index'
        expect(response).to have_http_status 200
      end
    end
  end

  describe 'PATCH update' do
    context 'valid' do
      it 'update' do
        patch :update, params:{topic: {title:'Growth'},id:topic.id}
        expect(assigns(:topic).title).to eq 'Growth'
        expect(flash[:notice]).to eq "Topic was successfully updated."
        expect(response).to have_http_status 302
      end
    end
  end

  describe 'POST create' do
    context 'valid' do
      it 'create' do
        expect{ post :create,params: { topic: {title: "Hulk2", content: "Green man"}}}.to change(Topic, :count).by(1)
        expect(assigns(:topic).title).to eq 'Hulk2'
        expect(flash[:notice]).to eq "Topic was successfully created."
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/topics/#{assigns(:topic).id}"
      end
    end
  end
end
