module API
  module V1
    class BucketlistsController < ApplicationController
      before_action only: [:show, :update, :destroy] do
        set_bucketlist(params[:id])
      end

      def show
        json_response(@bucketlist)
      end

      def index
        @bucketlists = if query_present?
                         @current_user.bucketlists.search(params[:q]).
                           paginate(params)
                       else
                         @current_user.bucketlists.paginate(params)
                       end
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
    end
  end
end
