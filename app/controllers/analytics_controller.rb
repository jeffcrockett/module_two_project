class AnalyticsController < ApplicationController

    def index 
        @artists = Artist.all
        @most_frequent_notemaker = User.most_notes.username
        @longest_song = Song.longest
        @largest_album = Album.largest
    end

    def ordered_by_albums
        @artists = Artist.ordered_by_album_count
        redirect_to analytics_path
    end

    def ordered_by_songs
        @artists = Artist.ordered_by_song_count
        redirect_to analytics_path
    end

    def ordered_by_lyrics
        @artists = Artist.ordered_by_lyrics_count
        redirect_to analytics_path
    end
end