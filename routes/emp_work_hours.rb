require 'pry'

get '/employees/:id/work_hours/edit' do
        if admin_logged_in?
        @weekdays = %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)
        @employee = Employee.find(params[:id])
        erb :"work_hours/create_work_hours", layout: :'layouts/admin'
    else
        redirect '/'
    end
end

post '/employees/:employee_id/workhours' do
    if admin_logged_in?
        EmpWorkHour.where(employee_id: params[:employee_id], :work_date => Date.parse(params["start"])..Date.parse(params["end"])).destroy_all

        (Date.parse(params["start"])..Date.parse(params["end"])).each do |date|
            weekday = get_week_day(date)
            if !!params[weekday]
                availability = EmpWorkHour.new(
                    employee_id: params[:employee_id],
                    work_date: date,
                    author_id: session[:employee_id],
                    date_created: Time.now,
                    last_updated: Time.now,
                    active: true,
                    start_time: params["#{weekday}-start-time"],
                    end_time: params["#{weekday}-end-time"]
                )
                availability.save
            end
        end   
        redirect "/employees/#{params[:employee_id]}"
    else
        redirect '/'
    end
end

get '/work_hours' do
    if admin_logged_in?
        @work_hours = EmpWorkHour.where(active: true).order(:work_date)
        erb :"work_hours/work_hours", layout: :'layouts/admin'
    else
        redirect '/'
    end
end

get '/work_hours/:id/edit' do
    if admin_logged_in?
        @schedule = EmpWorkHour.find(params[:id])

        erb :"work_hours/edit_work_hours", layout: :'layouts/admin'
    else
        redirect '/'
    end
end

put '/work_hours/:id' do
    if admin_logged_in?
        schedule = EmpWorkHour.find(params[:id])
        schedule.work_date = params["work-date"]
        schedule.start_time = params["start-time"]
        schedule.end_time = params["end-time"]
        schedule.last_updated = Time.now
        schedule.save
        redirect '/work_hours'
    else
        redirect '/'
    end
end

put '/work_hours/:id/delete' do
    if admin_logged_in?
        schedule = EmpWorkHour.find(params[:id])
        schedule.active = false
        schedule.save
        redirect '/work_hours'
    else
        redirect '/'
    end
end

