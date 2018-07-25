class EmpWorkHour < ActiveRecord::Base

    belongs_to :employee, foreign_key: 'author_id'
    belongs_to :employee, foreign_key: 'employee_id'
    
    def self.gen_work_hours(params, author)
        EmpWorkHour.where(employee_id: params[:employee_id], :work_date => Date.parse(params["start"])..Date.parse(params["end"])).destroy_all

        (Date.parse(params["start"])..Date.parse(params["end"])).each do |date|
            weekday = get_week_day(date)
            if !!params[weekday]
                availability = EmpWorkHour.new(
                    employee_id: params[:employee_id],
                    work_date: date,
                    author_id: author,
                    date_created: Time.now,
                    last_updated: Time.now,
                    active: true,
                    start_time: params["#{weekday}-start-time"],
                    end_time: params["#{weekday}-end-time"]
                )
                availability.save
            end
        end   
    end
end