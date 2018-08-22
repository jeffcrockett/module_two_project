# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require_relative 'test_api'


#the beatles artist id = 160
#the rolling stones artist id = 383
#radiohead artist id = 49
parser = Parser.new(49)
seed_hash = parser.albums_songs_lyrics_hash(parser.albums_songs_hash(parser.album_ids))

# BEATLES_SONGS_ALBUM_HASH = {"Best Selection 1962-1968 Part 3"=>[{"I Feel Fine"=>["Baby's good to me, You know", "She's happy as can be, Youknow", "She said so", "I'm in love with her and I Feel Fine", "", "Baby says She's mine, You know", "She tells me all the time, You know", "She said so", "I'm in love with her and I Feel Fine", "...", "", "******* This Lyricsis NOT for Commercial use *******", "(1409617886070)"]}, {"You're Going to Lose That Girl"=>["You're gonna lose that girl", "(Yes, yes, you're gonna lose that girl)", "You're gonna lose that girl", "(Yes, yes, you're gonna lose that girl)", "", "If you don't take her out tonight", "She's gonna change her mind", "(She's gonna change her mind)", "And I will take her out tonight", "And I will treat her kind", "(I'm gonna treat her kind)", "", "You'regonna lose that girl", "(Yes, yes, you're gonna lose that girl)", "You're gonna lose that girl", "(Yes, yes, you're gonna lose that girl)", "", "If you don't treat her right, my friend
# the_beatles = Artist.create(name: "The Beatles")
radiohead = Artist.create(name: "Radiohead")
seed_hash.each do |album_name, song_hash_array|
    album = Album.find_or_create_by(name: album_name, artist: radiohead)
    song_hash_array.each do |hash|
        hash.each do |song_name, lyrics_array|
            song = Song.find_or_create_by(name: song_name, album: album)
                lyrics_array[0..-5].each do |line|
                Line.find_or_create_by(name: line, song: song)
                end
            end
        end
    end
# def parse_beatles
#         html = Nokogiri::HTML(open('http://beatlesnumber9.com/lyrics.html'))
#         songs = html.css('p')[16..650]
#         songs.each_with_index do |song, index|
#             if index % 3 == 0
#                 new_song = Song.create(name: song.text.split(/(\r\n)+/).last)
#                 lines = songs[index+1].text.split(/\r\n/).delete_if{|line| line.length==0}
#                 lines.each do |line|
#                     Line.create(name: line, song_id: new_song.id)

#                 end
#             else
#                 # binding.pry
#                 next
#             end
#         end
#         # binding.pry
#         #first song title at html.css('p')[16]
#     end

#     parse_beatles
