get '/employee/me' do
    if logged_in_employee
        @employee = Employee.find(session[:employee_id])
        erb :"employees/show_me", layout: :'layouts/admin'
    else
        redirect '/'
    end
end
get '/employee/me/edit' do
    if logged_in_employee
        @employee = Employee.find(session[:employee_id])
        @titles = %w(Mrs Mr Miss Miss Master Sir Lady Lord Dr)
        erb :"/employees/edit_me", layout: :'layouts/admin'
    else
        redirect '/'
    end
end
put '/employee/me' do
    if logged_in_employee
        employee = Employee.find(session[:employee_id])
        employee.first_name = params["first-name"]
        employee.last_name = params["last-name"]
        employee.preferred_name = params["preferred-name"] || params["first-name"]
        employee.title = params["title"]
        employee.email = params["email"]
        employee.dob = params["dob"]
        employee.phone = params["phone"]
        employee.last_update = Time.now
        employee.save
        redirect "/employee/me"
    else
        redirect '/'
    end
end
