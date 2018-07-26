class Client < ActiveRecord::Base
    has_secure_password
    has_many :client_notes
    has_many :booking_requests
    
    def full_legal_name
        "#{first_name} #{last_name}"
    end
    def full_preferred_name
        "#{preferred_name} #{last_name}"
    end
    def full_legal_name_title
        "#{title} #{first_name} #{last_name}"
    end
    
end