helpers do
    def set_locale
      if params[:locale]
        session[:locale] = params[:locale]
        I18n.locale = params[:locale]
        redirect '/'
      end
  
      I18n.locale = session[:locale] || "en"
    end
  
    def user_signed_in?
      !session[:user_id].nil?
    end
  
    def current_user
      
      if @current_user.nil? && user_signed_in?
        @current_user = User.find(session[:user_id]);
      end
  
      @current_user;
    end
  
    def option_select(value, text)
      selected = session[:locale] == value ? ' selected' : ''
      "<option value=#{value}#{selected}>#{text}</option>"
    end
end