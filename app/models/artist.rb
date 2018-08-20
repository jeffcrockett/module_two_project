class Artist < ApplicationRecord
    has_many :albums
    has_many :songs, through: :albums 
    has_many :lines, through: :songs
    has_many :notes, through: :lines

    # def self.get_potential_artists(query) 
    #     json = JSON.parse(RestClient.get("https://api.musixmatch.com/ws/1.1/artist.search?format=jsonp&callback=callback&q_artist=#{self.formatted(query)}&apikey=1d628b26f4bb8472f6ad706b87f6be07").body[9..-3])
    #     json['message']['body']['artist_list'].map do |hash| hash['artist']['artist_name'] end
    #     # binding.pry
    # end


end
# Artist.new.get_potential_artists('the beatles')