class Artist < ApplicationRecord
    has_many :albums
    has_many :songs, through: :albums 
    has_many :lines, through: :songs
    has_many :notes, through: :lines

    def total_albums 
        albums.count 
    end

    def total_songs
        songs.count 
    end

    def total_lyrics
        lines.count 
    end

    def vocabulary_score
         ((songs.map(&:words_ratio).reduce(:+) / songs.length) * 100).round(2)
    end

    def unique_songs
        songs.map(&:name).uniq.map do |title| Song.where(name: title).first end.sort_by do |song| song.name end
    end

    def self.ordered_by_album_count
        self.all.sort_by do |artist| artist.total_albums end.reverse
    end

    def self.ordered_by_song_count
        self.all.sort_by do |artist| artist.total_songs end.reverse
    end

    def self.ordered_by_lyrics_count
        self.all.sort_by do |artist| artist.total_lyrics end.reverse
    end

    def self.ordered_by_vocabulary_score
        self.all.sort_by do |artist| artist.vocabulary_score end.reverse
    end



    # def self.get_potential_artists(query) 
    #     json = JSON.parse(RestClient.get("https://api.musixmatch.com/ws/1.1/artist.search?format=jsonp&callback=callback&q_artist=#{self.formatted(query)}&apikey=1d628b26f4bb8472f6ad706b87f6be07").body[9..-3])
    #     json['message']['body']['artist_list'].map do |hash| hash['artist']['artist_name'] end
    #     # binding.pry
    # end


end
# Artist.new.get_potential_artists('the beatles')