module API
  module V1
    class BucketListsController < ApplicationController
      before_action :set_bucket_list, only: [:show, :update, :destroy]

      def show
        render json: @bucket_list, status: :ok
      end

      def index
        @bucket_lists = BucketList.all
        render json: @bucket_lists, status: :ok
      end

      def create
        @bucket_list = BucketList.new(list_params)
        if @bucket_list.save
          render json: @bucket_list, status: :created
        else
          render json: @bucket_list.errors, status: :unprocessable_entity
        end
      end

      def update
        if @bucket_list.update(list_params)
          head :no_content
        else
          render json: @bucket_list.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @bucket_list.destroy
        head :no_content
      end

      private

      def set_bucket_list
        @bucket_list = BucketList.find(params[:id])
      end

      def list_params
        params.permit(:name, :created_by)
      end
    end
  end
end
