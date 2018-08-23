class Album < ApplicationRecord
    belongs_to :artist
    has_many :songs
    has_many :lines, through: :songs 
    has_many :notes, through: :lines 

    def self.largest
        self.all.sort_by do |album| album.songs.length end.last
    end

    def artist_name
        artist ? artist.name : nil 
    end
end
