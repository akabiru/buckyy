require "rails_helper"

RSpec.describe API::V1::ApplicationController, type: :controller do
  it { should rescue_from(ActiveRecord::RecordNotFound) }

  it { should rescue_from(ActiveRecord::RecordNotSaved) }

  it { should rescue_from(ActiveRecord::RecordInvalid) }
end
