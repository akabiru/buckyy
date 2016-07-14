RSpec.shared_examples "a paginable resource" do |options|
  context "when page #{options[:page]} limit #{options[:limit]}" do
    let!(:req) do
      get "/bucketlists", { page: options[:page], limit: options[:limit] },
          headers
    end
    let!(:size) { correct_size(options) }
    let(:bucketlist_id) { correct_bucketlist(options) }

    it_behaves_like "a http response", 200

    it "returns #{@size} bucketlists from page #{options[:page]}" do
      expect(json.first["id"]).to eq(bucketlist_id)
      expect(json.size).to eq(size)
    end
  end

  def correct_size(options)
    @size = if options[:limit] > 100
              100
            elsif options[:limit] <= 0
              20
            else
              options[:limit]
            end
    @size
  end

  def correct_bucketlist(options)
    position = (options[:page] - 1) * size
    bucketlists[position].id
  end
end
