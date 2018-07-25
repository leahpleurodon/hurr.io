post '/employee/me/image' do
    if logged_in_employee
        tempfile = params[:file][:tempfile] 
        fileext = File.extname(params[:file][:filename])
        img_path = "/uploads/photos/employee/employee_#{session[:employee_id]}#{fileext}"
        FileUtils.cp(tempfile.path, "#{FileUtils.pwd}/public/#{img_path}")
        emp = Employee.where(id: session[:employee_id])[0]
        emp.photo = img_path
        emp.save
        redirect 'employee/me'
    else
        redirect '/'
    end
end

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
        employee.photo = params["photo"]
        employee.last_update = Time.now
        employee.save
        redirect "/employee/me"
    else
        redirect '/'
    end
end
