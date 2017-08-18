class ArticlesController
  def get_articles_for_params(params)
    valid_sorting_attributes = %w[date title]
    if !params[:sort_by].nil? && valid_sorting_attributes.include?(params[:sort_by])
      valid_sorting_orders = %w[ASC DESC]
      sorting_order = valid_sorting_orders.include?(params[:order]) ?
                                   params[:order] : 'ASC'
      if params[:sort_by] != 'date'
        @articles = Article.order("#{params[:sort_by]}_#{I18n.locale} #{sorting_order}")
      else
        @articles = Article.order("created_at #{sorting_order}")
      end
    else
      @articles = Article.order('created_at DESC')
    end
  end
end
