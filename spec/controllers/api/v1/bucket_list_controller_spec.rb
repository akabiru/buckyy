require 'rails_helper'

RSpec.describe API::V1::BucketListsController, type: :controller do
  let!(:bucket_list) { create(:bucket_list) }

  describe 'GET #index' do
    before { get :index }

    it 'returns a status code 200' do
      expect(response.status).to eq(200)
    end

    it 'assigns bucket_lists to @bucket_lists' do
      expect(assigns(:bucket_lists)).to eq(BucketList.all)
    end
  end

  describe 'GET #show' do
    before { get :show, id: bucket_list.id }

    it 'returns a status code 200' do
      expect(response.status).to eq(200)
    end

    it 'assigns bucket_list to @bucket_list' do
      expect(assigns(:bucket_list)).to eq(bucket_list)
    end

    it 'shows a bucket_list' do
      parsed_response = json(response.body)
      expect(parsed_response["name"]).to eq(bucket_list.name)
    end
  end

  describe 'POST #create' do
    let(:bucket_list) { build(:bucket_list) }

    context 'when valid request' do
      it 'returns a status code 201' do
        post :create, { name: bucket_list.name, created_by: bucket_list.created_by }
        expect(response.status).to eq(201)
      end

      it 'creates a new bucket_list' do
        expect do
          post :create, { name: bucket_list.name, created_by: bucket_list.created_by }
        end.to change(BucketList, :count).by(1)
      end
    end

    context 'when invalid request' do
      it 'returns a status code 422' do
        post :create, { name: nil, created_by: bucket_list.created_by }
        expect(response.status).to eq(422)
      end

      it 'does not create a new bucket_list' do
        expect do
          post :create, { name: nil, created_by: bucket_list.created_by }
        end.to change(BucketList, :count).by(0)
      end
    end
  end
end
