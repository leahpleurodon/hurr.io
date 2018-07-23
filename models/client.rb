class Client < ActiveRecord::Base

    def full_legal_name
        "#{first_name} #{last_name}"
    end
    def full_prefered_name
        "#{preferred_name} #{last_name}"
    end
    def full_legal_name_title
        "#{title} #{first_name} #{last_name}"
    end
    
end