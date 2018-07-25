class EmpWorkHour < ActiveRecord::Base

    belongs_to :employee, foreign_key: 'author_id'
    belongs_to :employee, foreign_key: 'employee_id'
    

end