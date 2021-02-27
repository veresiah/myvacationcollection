class CollectionsController < ApplicationController
    get '/collections' do 
        @collections = Collection.all 
        erb :'collections/index'
    end 

    get 'collections/new' do    
        erb :'collections/new'
    end  

    get 'collections/:id' do 
        @collection = Collection.find(params[:id])
        erb :'collections/show'
    end 

    get 'collections/:id/edit' do 
    @collection = Collection.find(params[:id])
        erb :'collections/edit'
    end 

    post 'collections/:id' do 
        @collection = Collection.find(parmas[:id])
        @collection.destination = params['collection']['destination']
        @collection.start_date = params['collection']['start_date']
        @collection.end_date = params['collection']['end_date']
        @collection.trip_summary = params['collection']['trip_summary']
        @collection.save
        redirect "collections/#{@collection.id}"
    end 
end 