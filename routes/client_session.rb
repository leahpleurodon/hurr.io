get '/client_sessions' do
  if logged_in_client
    redirect '/'
  else
    erb :"sessions/client_sessions"
  end

end
  
post '/client_session' do
  client = Client.find_by(email: params[:email], active: true)
  if client && client.authenticate(params[:password])
    session[:client_id] = client.id
    redirect '/'
  else
    erb :"sessions/client_sessions"
  end
end

delete '/client_session' do
  session[:client_id] = nil
  redirect '/sessions/client_sessions'
end
  