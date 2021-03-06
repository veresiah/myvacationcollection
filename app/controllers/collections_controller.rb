class CollectionsController < ApplicationController
    get '/collections' do 
        redirect_if_not_logged_in
        @collections = current_user.collections 
        erb :'collections/index'
    end 

    get '/collections/new' do  
        redirect_if_not_logged_in 
        erb :'collections/new'
    end  

    get '/collections/:id' do 
        redirect_if_not_logged_in
        @collection = Collection.find(params[:id])
        if @collection.user == current_user
            erb :'collections/show'
        else
            flash[:error] = "Access denied!"
            redirect "/collections"
        end
    end 

    get '/collections/:id/edit' do 
        redirect_if_not_logged_in
        @collection = Collection.find(params[:id])
        if @collection.user == current_user
            erb :'collections/edit'
        else
            flash[:error] = "Access denied!"
            redirect "/collections"
        end
    end 

    post '/collections' do 
        redirect_if_not_logged_in
        collection = current_user.collections.build(destination: params[:destination], start_date: params[:start_date],end_date: params[:end_date], trip_summary: params[:trip_summary])
        if collection.save
            redirect "/collections/#{collection.id}"
        else 
            flash[:error] = collection.errors.full_messages.to_sentence
            redirect '/collections/new'
        end     
    end 

    patch '/collections/:id' do 
        redirect_if_not_logged_in
        collection = Collection.find(params[:id])
        if collection && collection.user == current_user
            if collection.update(destination: params[:destination], start_date: params[:start_date], end_date: params[:end_date], trip_summary: params[:trip_summary])
                redirect "/collections/#{collection.id}"
            else 
                redirect "/collections/#{collection.id}/edit"
            end 
        else
            flash[:error] = "Access denied!"
            redirect '/collections'
        end 
    end 

    delete '/collections/:id' do 
        redirect_if_not_logged_in
        collection = Collection.find(params[:id])
        if collection.destroy
            flash[:success] = "Collection successfully destroyed"
            redirect '/collections'
        else
            flash[:error] = collection.errors.full_messages.to_sentence
            redirect "/collections/#{collection.id}"
        end
    end 
end 