class Article < ActiveRecord::Base
    def title
        self["title_#{I18n.locale}"]
    end
    
    def text
        self["text_#{I18n.locale}"]
    end

    def description
        "#{self["text_#{I18n.locale}"][0..210]}.."
    end
end
