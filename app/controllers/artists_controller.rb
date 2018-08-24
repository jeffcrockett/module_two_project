require_relative '../../db/test_api'

class ArtistsController < ApplicationController
    before_action :set_artist, only: [:show, :edit, :update, :destroy]
    def index
        @artists = Artist.all
    end

    def seed 

        id = params["artist_id"].to_i
        artist_name = params["artist_name"]
        parser = Parser.new(id)
        # byebug
        parser.seed(artist_name)
        Song.all.select do |song| 
            song.word_count == 0 
        end.each do |song|
            song.destroy 
        end
 
        redirect_to artists_path

    end

    def search
        # binding.pry
        formatted_query = params[:query].gsub(/ +/, '%20')
            .gsub(/"+/, '%22')
            .gsub(/,+/, '%2C')
            .gsub(/\//, '%2F')
            .gsub(/\\/, '%5C')
        json = JSON.parse(RestClient.get("https://api.musixmatch.com/ws/1.1/artist.search?format=jsonp&callback=callback&q_artist=#{formatted_query}&apikey=#{RAILS_API_KEY}").body[9..-3])
        @potential_artists = json['message']['body']['artist_list'].each_with_object({}) do |hash, obj| 
            name = hash['artist']['artist_name'] 
            id = hash['artist']['artist_id']
            obj[name] = id
        end
         
    end

    def formatted(query)
        query.gsub(/ +/, '%20')
            .gsub(/"+/, '%22')
            .gsub(/,+/, '%2C')
            .gsub(/\//, '%2F')
            .gsub(/\\/, '%5C')
    end

    private 


    def set_artist 
        @artist = Artist.find(params[:id])
    end
end
