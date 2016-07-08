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
    @limit = if @limit <= 0
      DEFAULT_LIMIT
    elsif @limit > MAX_LIMIT
      MAX_LIMIT
    else
      @limit
    end
    @offset = @offset >= 1 ? ((@offset - 1) * @limit) : 0
  end
end
