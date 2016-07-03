require "rails_helper"

RSpec.shared_examples "an api controller" do |id_params|
  describe "rescues from Active::RecordRecordNotFound" do
    context "on GET #show" do
      before { get :show, id_params }

      it { expect(response).to have_http_status(404) }
      it { expect(response.body).to match(/Couldn't find/)  }
    end

    context "on PUT #update" do
      before { put :update, id_params }

      it { expect(response).to have_http_status(404) }
      it { expect(response.body).to match(/Couldn't find/) }
    end

    context "on DELETE #destroy" do
      before { delete :destroy, id_params }

      it { expect(response).to have_http_status(404) }
      it { expect(response.body).to match(/Couldn't find/) }
    end
  end
end
