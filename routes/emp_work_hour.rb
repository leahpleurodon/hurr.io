get '/employees/:id/work_hours/edit' do
    redirect '/admin_index' unless admin_logged_in?
        @weekdays = %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)
        @employee = Employee.find(params[:id])
        erb :"work_hours/create_work_hours", layout: :'layouts/admin'
end

post '/employees/:employee_id/workhours' do
    redirect '/admin_index' unless admin_logged_in?
        EmpWorkHour.gen_work_hours(params, session[:employee_id])
        redirect "/employees/#{params[:employee_id]}"
end

get '/work_hours' do
    redirect '/admin_index' unless admin_logged_in?
        @work_hours = EmpWorkHour.where(active: true).order(:work_date)
        erb :"work_hours/index", layout: :'layouts/admin'
end

get '/work_hours/:id/edit' do
    redirect '/admin_index' unless admin_logged_in?
        @schedule = EmpWorkHour.find(params[:id])

        erb :"work_hours/edit_work_hours", layout: :'layouts/admin'
end

put '/work_hours/:id' do
    redirect '/admin_index' unless admin_logged_in?
        schedule = EmpWorkHour.find(params[:id])
        schedule.work_date = params["work-date"]
        schedule.start_time = params["start-time"]
        schedule.end_time = params["end-time"]
        schedule.last_updated = Time.now
        schedule.save
        redirect '/work_hours'
end

put '/work_hours/:id/delete' do
    redirect '/admin_index' unless admin_logged_in?
        schedule = EmpWorkHour.find(params[:id])
        schedule.active = false
        schedule.save
        redirect '/work_hours'
end

