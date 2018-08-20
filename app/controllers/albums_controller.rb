class AlbumsController < ApplicationController
    before_action :set_album, only: [:show, :edit, :update, :destroy]
    def show
    end

    def index 
        @artists = Artist.all.order(:name)
        @albums = Album.all.order(:name) 
    end

    private

    def set_album
        @album = Album.find(params[:id])
    end
end
