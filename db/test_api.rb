require 'rest-client'
require 'json'
require 'pry'

#testing new code for the seeds file
#beatles artist id = 160
BEATLES_ALBUMS_HASH = {"Best Selection 1962-1968 Part 3"=>10440726, "Past Masters"=>10284940, "The Beatles Box Set"=>15429649, "Abbey Road"=>14335055, "The Beatles"=>14280708, "Please Please Me"=>20749304, "Help!"=>14314875, "Sgt. Pepper’s Lonely Hearts Club Band"=>19636447, "Sgt. Pepper's Lonely Hearts Club Band"=>20483464, "Revolver"=>10402514}

BEATLES_ALBUMS_SONGS_HASH = {"Best Selection 1962-1968 Part 3"=>{"I Feel Fine"=>2718821, "You're Going to Lose That Girl"=>2718822}, "Past Masters"=>{"Love Me Do"=>18736805, "From Me to You"=>18736806}, "The Beatles Box Set"=>{"I Saw Her Standing There"=>33151644, "Misery"=>33151645}, "Abbey Road"=>{"Come Together"=>19944669, "Something"=>19944670}, "The Beatles"=>{"Back in the U.S.S.R."=>18912245, "Dear Prudence"=>18912246}, "Please Please Me"=>{"I Saw Her Standing There"=>82665775, "Misery"=>82665776}, "Help!"=>{"Help!"=>19571491, "The Night Before"=>19571492}, "Sgt. Pepper’s Lonely Hearts Club Band"=>{"Sgt. Pepper’s Lonely Hearts Club Band"=>73266598, "With a Little Help From My Friends"=>73266599}, "Sgt. Pepper's Lonely Hearts Club Band"=>{"Sgt. Pepper’s Lonely Hearts Club Band"=>80508708, "With a Little Help From My Friends"=>80508709}, "Revolver"=>{"Taxman"=>30215251, "Eleanor Rigby"=>30215253}}

class Parser
    def initialize(id)
        @artist_id = id
    end
    def album_ids
        json = JSON.parse(RestClient.get("https://api.musixmatch.com/ws/1.1/artist.albums.get?format=jsonp&callback=callback&artist_id=#{@artist_id}&page_size=100&apikey=1d628b26f4bb8472f6ad706b87f6be07").body[9..-3])
        json['message']['body']['album_list'].each_with_object({}) do |album, obj|
            name = album['album']['album_name']
            id = album['album']['album_id']
            obj[name] = id
        end

    end

    def album_tracks_from(album_id)
        json = JSON.parse(RestClient.get("https://api.musixmatch.com/ws/1.1/album.tracks.get?format=jsonp&callback=callback&album_id=#{album_id}&apikey=1d628b26f4bb8472f6ad706b87f6be07").body[9..-3])
        json['message']['body']['track_list'].each_with_object({}) do |track, obj|
            name = track['track']['track_name']
            id = track['track']['track_id']
            obj[name] = id
        end
    # binding.pry
    end

    def lyrics_from(track_id)
        json = JSON.parse(RestClient.get("https://api.musixmatch.com/ws/1.1/matcher.lyrics.get?format=jsonp&callback=callback&track_id=#{track_id}&apikey=1d628b26f4bb8472f6ad706b87f6be07").body[9..-3])
        # binding.pry
        #   binding.pry
        if json['message']['header']['status_code'] == 404
            return ['No lyrics']
        else
            json['message']['body']['lyrics']['lyrics_body'].split(/\n/)
        end
    end

    def albums_songs_hash(ids)
        #ids is output of album_ids
        ids.each_with_object({}) do |(key, value), obj| obj[key] = album_tracks_from(value) end

    end

    def albums_songs_lyrics_hash(albums_songs)
        #albums_songs is output of albums_songs_hash
        # binding.pry
        albums_songs.each_with_object({}) do |(album_name, song_name_hash), obj|
            #IT BREAKS HERE

            song_name_hash.each do |song_name, song_id|

                obj[album_name] ||= []
                obj[album_name] << {song_name => lyrics_from(song_id)}

            end

        end

    end

    def seed(artist_name)
        new_artist = Artist.find_or_create_by(name: artist_name)

        seed_hash = albums_songs_lyrics_hash(albums_songs_hash(album_ids))
        #BROKEN HERE
        # binding.pry
        seed_hash.each do |album_name, song_hash_array|

        album = Album.find_or_create_by(name: album_name, artist: new_artist)
        song_hash_array.each do |hash|
            hash.each do |song_name, lyrics_array|
                song = Song.find_or_create_by(name: song_name, album: album)
                lyrics_array[0..-5].each do |line|
                Line.find_or_create_by(name: line, song: song)
                end
            end
        end
    end
end
# puts album_ids
# tracks = album_ids.each_with_object({}) do |(key, value), obj| obj[key] = album_tracks_from(value) end
# puts tracks
end
    # parser = Parser.new(160)
    # puts parser.albums_songs_lyrics_hash(parser.albums_songs_hash(parser.album_ids))
