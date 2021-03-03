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
            @collection.destination = params[:destination]
            @collection.start_date = params[:start_date]
            @collection.end_date = params[:end_date]
            @collection.trip_summary = params[:trip_summary]
            @collection.save
            redirect "collections/#{@collection.id}"
        end 
    end 

    post '/collections' do 
        if logged_in?
            Collection.create(destination: params[:destination], start_date: params[:start_date],end_date: params[:end_date], trip_summary: params[:trip_summary])
            redirect '/collections'
        
        end 
    end 

    #blank page with no content at '/collections#{@collection.id}' after editing collection
    patch '/collections/:id' do 
        if logged_in? 
            if params[:destination].empty? 
                redirect '/collections/#{params[:id]}/edit'
                if params[:start_date].empty? 
                    redirect '/collections/#{params[:id]}/edit'
                    if params[:end_date].empty?
                        redirect '/collections/#{params[:id]}/edit'
                        if params[:trip_summary].empty?
                            redirect '/collections/#{params[:id]}/edit'
                        else 
                            @collection = Collection.find(params[:id])
                            if @collection
                                if @collection.update(destination: params[:destination], start_date: params[:start_date], end_date: params[:end_date], trip_summary: params[:trip_summary])
                                    redirect '/collections#{@collection.id}'
                                else 
                                    redirect '/collections/#@collection.id}/edit'
                                end 
                            else 
                                redirect '/collections'
                            end 
                        end 
                    end
                end 
            end 
        else 
            redirect_to_login
        end 
    end 

    #fix sinatra error - doesn't know this ditty
    delete '/collections/:id/delete' do 
        if logged_in?
            @collection = Collection.find(params[:id])
            @collection.delete  
            redirect '/collections'
        else 
            redirect_to_login
        end 
    end 
end 