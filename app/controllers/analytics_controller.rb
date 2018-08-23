class AnalyticsController < ApplicationController
before_action :sorting_things, only: [:index, :ordered_by_albums, :ordered_by_songs, :ordered_by_lyrics]

    def index
        @artists = Artist.all
    end

    def ordered_by_albums
        @artists = Artist.ordered_by_album_count
        render :index
    end

    def ordered_by_songs
        @artists = Artist.ordered_by_song_count
        render :index
    end

    def ordered_by_lyrics
        @artists = Artist.ordered_by_lyrics_count
        render :index
    end

    private

    def sorting_things
      @most_frequent_notemaker = User.most_notes.username
      @note_count = User.most_notes.notes.count
      @longest_song = Song.longest
      @line_count = @longest_song.lines.count
      @largest_album = Album.largest
      @song_count = @largest_album.songs.count
    end
end
