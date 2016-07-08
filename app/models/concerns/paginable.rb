module Paginable
  def paginate(params)
    values = Pagination.new(params).perform
    limit(values[:limit]).offset(values[:offset])
  end
end
