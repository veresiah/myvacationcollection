class ApplicationController < ApplicationController

  # GET: /applications
  get "/applications" do
    erb :"/applications/index.html"
  end

  # GET: /applications/new
  get "/applications/new" do
    erb :"/applications/new.html"
  end

  # POST: /applications
  post "/applications" do
    redirect "/applications"
  end

  # GET: /applications/5
  get "/applications/:id" do
    erb :"/applications/show.html"
  end

  # GET: /applications/5/edit
  get "/applications/:id/edit" do
    erb :"/applications/edit.html"
  end

  # PATCH: /applications/5
  patch "/applications/:id" do
    redirect "/applications/:id"
  end

  # DELETE: /applications/5/delete
  delete "/applications/:id/delete" do
    redirect "/applications"
  end
end
