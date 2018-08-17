# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'nokogiri'
require 'open-uri'


def parse_beatles
        html = Nokogiri::HTML(open('http://beatlesnumber9.com/lyrics.html'))
        songs = html.css('p')[16..650]
        songs.each_with_index do |song, index|
            if index % 3 == 0
                new_song = Song.create(name: song.text.split(/(\r\n)+/).last)
                lines = songs[index+1].text.split(/\r\n/).delete_if{|line| line.length==0}
                lines.each do |line| 
                    Line.create(name: line, song_id: new_song.id)
             
                end                
            else
                # binding.pry
                next
            end
        end 
        # binding.pry
        #first song title at html.css('p')[16]
    end

    parse_beatles