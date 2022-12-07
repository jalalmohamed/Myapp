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
        patch :update, params: { topic: { title: "Growth", content:"2nd updated"}}
        #except(assigns(:topic).title).to eq 'Growth'
        except(flash[:notice]).to eq "Topic was successfully updated."
        except(response).to have_http_status 302
      end
    end
  end
end
