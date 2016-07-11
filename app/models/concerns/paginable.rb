module Paginable
  def paginate(params)
    values = Pagination.new(params).call
    limit(values[:limit]).offset(values[:offset])
  end
end
