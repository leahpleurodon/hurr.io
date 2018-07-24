
  get '/client_note/:id' do
    @note = ClientNote.find(params[:id])
  end

  get '/client_notes' do
    @notes = ClientNote.where(active: true)
  end
  
  post '/client_note' do
      note = ClientNote.new(
        note: params["note"],
        active: true,
        client_id: params["client-id"],
        last_update: Time.now,
        date_created: Time.now
      )
      note.save
    redirect "/clients/#{params["client-id"]}"
  end
  
  get '/client_notes/:id/edit' do
    @note = ClientNote.find(params[:id])
    erb :"client_notes/edit"
  end
  
  put '/client_notes/:id/deactivate' do
      note = ClientNote.find(params[:id])
      note.active = false
      note.save
      redirect "/clients/#{note.client_id}"
  end

  put '/client_notes/:id' do
      note = ClientNote.find(params[:id])
      note.note = params["note"]
      note.save
      redirect "/clients/#{note.client_id}"
  end

  