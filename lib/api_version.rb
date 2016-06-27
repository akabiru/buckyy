class ApiVersion
  attr_reader :version

  def initialize(version, default = false)
    @version = version
    @default = default
  end

  def matches?(headers)
    @default || check_headers(headers)
  end

  private

  def check_headers(headers)
    accept = headers["Accept"]
    accept && accept.include?("application/vnd.bucketlists.#{@version}+json")
  end
end
