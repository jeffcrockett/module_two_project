class Line < ApplicationRecord
    belongs_to :song, optional: true
    has_many :notes

    def album
        song ? song.album : nil
    end

    def artist
        album ? album.artist : nil 
    end
end

    
