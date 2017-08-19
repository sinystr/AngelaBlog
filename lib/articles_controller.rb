class ArticlesController
  def articles_for_params(params)
    if valid_sorting_attr?(params[:sort_by])
      sort_attr = sorting_attr(params[:sort_by])
      sort_order = sorting_order(params[:order])
      Article.order("#{sort_attr} #{sort_order}")
    else
      Article.order('created_at DESC')
    end
  end

  def sorting_attr(attr)
    attr == 'created_at' ? 'created_at' : "#{attr}_#{I18n.locale}"
  end

  def valid_sorting_attr?(attr)
    valid_sorting_attrs = %w[created_at title]
    !attr.nil? && valid_sorting_attrs.include?(attr)
  end

  def sorting_order(order)
    valid_sorting_orders = %w[ASC DESC]
    valid_sorting_orders.include?(order) ? order : 'ASC'
  end
end
