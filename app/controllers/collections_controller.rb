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
        @collection = current_user.collections.build(destination: params[:destination], start_date: params[:start_date],end_date: params[:end_date], trip_summary: params[:trip_summary])
        if @collection.save
            redirect '/collections/#{@collection.id}'
        else 
            flash[:error] = collection.errors.full_messages.to_sentence
            redirect '/collections/new'
        end 
    end 
 

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