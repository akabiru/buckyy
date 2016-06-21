module API
  module V1
    class ItemsController < ApplicationController
      before_action :set_bucket_list, only: [:index, :create]

      def index
        render json: @bucket_list.items
      end

      def create
        item = @bucket_list.items.new(item_params)
        if item.save
          render json: @bucket_list, status: :created
        else
          render json: item.errors, status: :unprocessable_entity
        end
      end

      private

      def set_bucket_list
        @bucket_list = BucketList.find(params[:bucket_list_id])
      end

      def item_params
        params.permit(:name, :done)
      end
    end
  end
end
