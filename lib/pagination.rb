class Pagination
  attr_reader :limit, :offset

  MAX_LIMIT = 100
  DEFAULT_LIMIT = 20

  def initialize(params)
    @limit = params[:limit].to_i
    @offset = params[:page].to_i
  end

  def perform
    check_limit_and_offset
    { offset: @offset, limit: @limit }
  end

  private

  def check_limit_and_offset
    @limit = DEFAULT_LIMIT if @limit <= 0 || @limit > MAX_LIMIT
    @offset = (@offset - 1) * @limit
  end
end
