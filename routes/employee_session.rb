get '/employee_sessions' do
    erb :"sessions/employee_sessions"
  end
  
  post '/employee_session' do
    employee = Employee.find_by(email: params[:email], active: true, terminated: false)
    if employee && employee.authenticate(params[:password])
      session[:employee_id] = employee.id
      redirect '/'
    else
      erb :"sessions/employee_sessions"
    end
  end
  
  delete '/employee_session' do
    session[:employee_id] = nil
    redirect '/sessions/employee_sessions'
  end
  