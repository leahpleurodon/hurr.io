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
        EmpWorkHour.gen_work_hours(params, session[:employee_id])
        redirect "/employees/#{params[:employee_id]}"
    else
        redirect '/'
    end
end

get '/work_hours' do
    if admin_logged_in?
        @work_hours = EmpWorkHour.where(active: true).order(:work_date)
        erb :"work_hours/index", layout: :'layouts/admin'
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

