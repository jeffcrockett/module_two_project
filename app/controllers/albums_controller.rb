class AlbumsController < ApplicationController
    before_action :set_album, only: [:show, :edit, :update, :destroy]
    def show
    end

    def index 
        @albums = Album.all 
    end

    private

    def set_album
        @album = Album.find(params[:id])
    end
end
