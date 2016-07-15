RSpec.shared_examples "a schema" do |schema|
  it "matches a #{schema} schema" do
    expect(response.body).to match_schema(schema)
  end
end
