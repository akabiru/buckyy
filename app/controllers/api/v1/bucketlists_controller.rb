module API
  module V1
    class BucketlistsController < ApplicationController
      before_action :set_bucketlist, only: [:show, :update, :destroy]
      before_action :search_bucketlist, if: :query_present?, only: :index

      def show
        json_response(@bucketlist)
      end

      def index
        @bucketlists = @current_user.bucketlists
        json_response(@bucketlists)
      end

      def create
        @bucketlist = @current_user.bucketlists.new(list_params)
        @bucketlist.save!
        json_response(@bucketlist, :created)
      end

      def update
        @bucketlist.update!(list_params)
        head :no_content
      end

      def destroy
        @bucketlist.destroy
        head :no_content
      end

      private

      def set_bucketlist
        @bucketlist = Bucketlist.find_by!(id: params[:id])
      end

      def list_params
        params.permit(:name, :created_by)
      end

      def query_present?
        params[:q].present?
      end

      def search_bucketlist
        bucketlist = Bucketlist.search!(params[:q])
        json_response(bucketlist)
      end
    end
  end
end
