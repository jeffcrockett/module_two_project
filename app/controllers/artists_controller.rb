class ArtistsController < ApplicationController
    before_action :set_artist, only: [:show, :edit, :update, :destroy]
    def index
        @artists = Artist.all
    end

    private 
    
    def set_artist 
        @artist = Artist.find(params[:id])
    end
end
