post '/client/me/image' do
    if logged_in_client
        tempfile = params[:file][:tempfile] 
        fileext = File.extname(params[:file][:filename])
        img_path = "/uploads/photos/client/client_#{session[:client_id]}#{fileext}"
        FileUtils.cp(tempfile.path, "#{FileUtils.pwd}/public/#{img_path}")
        emp = Client.where(id: session[:client_id])[0]
        emp.photo = img_path
        emp.save
        redirect 'client/me'
    else
        redirect '/'
    end
end

get '/client/me' do
    if logged_in_client
        @client = Client.find(session[:client_id])
        @client_notes = ClientNote.where(client_id: @client.id,active: true)
        erb :"clients/show_me", layout: :'layouts/public'    
    else
        redirect "/"
    end
end

put '/client/me/deactivate' do
    if logged_in_client
        client = Client.find(session[:client_id])
        client.active = false
        client.save
        session[:client_id] = nil
    end
    redirect "/"
end
get '/client/me/edit' do
    if logged_in_client
        @client = Client.find(session[:client_id])
        @titles = %w(Mrs Mr Miss Miss Master Sir Lady Lord Dr)
        erb :"/clients/edit", layout: :'layouts/public'
    elsif logged_in_employee
        redirect "/" 
    end
end