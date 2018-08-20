class SongsController < ApplicationController
    before_action :set_song, only: [:show, :edit, :update, :destroy]
    def index
        @artists = Artist.all.order(:name)
    end

    private

    def set_song
        @song = Song.find(params[:id])
    end

end
