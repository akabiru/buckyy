class Pagination
  attr_reader :limit, :offset

  MAX_LIMIT = 100
  DEFAULT_LIMIT = 20

  def initialize(params)
    @limit = params[:limit].to_i || DEFAULT_LIMIT
    @offset = params[:page].to_i || 0
  end

  def perform
    check_limit
    @offset = (@limit - 1) * (@offset - 1)
    { offset: @offset, limit: @limit }
  end

  private

  def check_limit
    @limit = DEFAULT_LIMIT if @limit <= 0 || @limit > MAX_LIMIT
  end
end
