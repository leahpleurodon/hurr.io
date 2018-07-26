get '/admin' do
    erb :"sessions/employee_sessions", layout: :'layouts/public'
  end
  
  post '/employee_session' do
    employee = Employee.find_by(email: params[:email], active: true, terminated: false)
    if employee && employee.authenticate(params[:password])
      session[:employee_id] = employee.id
      redirect '/admin_index'
    else
      erb :"sessions/employee_sessions", layout: :'layouts/public'
    end
  end
  
  delete '/employee_session' do
    session[:employee_id] = nil
    redirect '/admin_index'
  end
  