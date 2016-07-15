RSpec::Matchers.define :match_schema do |schema|
  match do |body|
    schema_directory = "#{Dir.pwd}/spec/support/schemas"
    schema_path = "#{schema_directory}/#{schema}.json"
    JSON::Validator.validate!(schema_path, body)
  end
end
