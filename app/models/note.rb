class Note < ApplicationRecord
    belongs_to :line
    belongs_to :user

    def song
      line ? line.song : nil
    end

    def song_name
      song ? song.name : nil
    end

    def album
      song ? song.album : nil
    end

    def album_name
      album ? album.name : nil
    end

    def artist
      album ? album.artist : nil
    end

    def artist_name
      artist ? artist.name : nil
    end

end
