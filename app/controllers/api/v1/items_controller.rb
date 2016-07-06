module API
  module V1
    class ItemsController < ApplicationController
      before_action :set_bucketlist
      before_action :set_bucketlist_item, only: [:show, :update, :destroy]

      def show
        json_response(@item)
      end

      def index
        json_response(@bucketlist.items)
      end

      def create
        @bucketlist.items.create!(item_params)
        json_response(@bucketlist, :created)
      end

      def update
        @item.update!(item_params)
        json_response(@bucketlist, :created)
      end

      def destroy
        @item.destroy
        head :no_content
      end

      private

      def set_bucketlist
        @bucketlist = Bucketlist.find_by!(id: params[:bucketlist_id])
      end

      def set_bucketlist_item
        @item = @bucketlist.items.find_by!(id: params[:id]) if @bucketlist
      end

      def item_params
        params.permit(:name, :done)
      end
    end
  end
end
