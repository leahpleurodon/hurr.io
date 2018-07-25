class Employee < ActiveRecord::Base
    has_secure_password
    has_many :client_notes, foreign_key: 'author_id'
    has_many :emp_work_hours, foreign_key: 'author_id'
    has_many :emp_work_hours, foreign_key: 'employee_id'

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