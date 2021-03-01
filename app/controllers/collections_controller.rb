class CollectionsController < ApplicationController
    get '/collections' do 
        if logged_in?
        @collections = Collection.all 
        erb :'collections/index'
        else 
            redirect_to_login
        end 
    end 

    get '/collections/new' do  
        if logged_in?  
        erb :'collections/new'
        else 
            redirect_to_login
        end 
    end  

    get '/collections/:id' do 
        if logged_in?
            @collection = Collection.find(params[:id])
            erb :'collections/show'
        end
    end 

    get '/collections/:id/edit' do 
        if logged_in?
            @collection = Collection.find(params[:id])
            erb :'collections/edit'
        end
    end 

    post '/collections/:id' do 
        if logged_in?
            @collection = Collection.find(parmas[:id])
            @collection.destination = params['collection']['destination']
            @collection.start_date = params['collection']['start_date']
            @collection.end_date = params['collection']['end_date']
            @collection.trip_summary = params['collection']['trip_summary']
            @collection.save
            redirect "collections/#{@collection.id}"
        end 
    end 

    post '/collections' do 
        if logged_in?
            Collection.create(destination: params['collection']['destination'], start_date: params['collection']['start_date'],end_date: params['collection']['end_date'], trip_summary: params['collection']['trip_summary'])
            redirect '/collections'
        end 
    end 

    


end 