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
end 