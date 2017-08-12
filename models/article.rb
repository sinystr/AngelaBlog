class Article < ActiveRecord::Base
    has_many :comments
    has_and_belongs_to_many :tags

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
