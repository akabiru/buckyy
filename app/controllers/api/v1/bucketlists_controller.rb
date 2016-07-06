module API
  module V1
    class BucketlistsController < ApplicationController
      before_action only: [:show, :update, :destroy] do
        set_bucketlist(params[:id])
      end
      before_action :search_bucketlist, if: :query_present?, only: :index

      def show
        json_response(@bucketlist)
      end

      def index
        @bucketlists = @current_user.bucketlists
        @bucketlists = @bucketlists.paginate(params) if pagination_present?
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

      def list_params
        params.permit(:name, :created_by)
      end

      def query_present?
        params[:q].present?
      end

      def pagination_present?
        params[:page].present? || params[:limit].present?
      end

      def search_bucketlist
        json_response(Bucketlist.search(params[:q]))
      end
    end
  end
end
