class User < ActiveRecord::Base
  has_many :notes
  validates :username, uniqueness: true

  has_secure_password

  def lines
    notes.map do |note| note.line end
  end

  def songs 
    lines.map do |line| line.song end 
  end

  def albums 
    songs.map do |song| song.album end
  end

  def artists 
    albums.map do |album| album.artist end
  end

  def self.most_notes
    self.all.sort_by do |user| user.number_of_notes end.last
  end

  def number_of_notes 
    notes.count
  end

  def most_commented_on_artist
    unless notes.empty?
      artist_frequency_hash = artists.each_with_object({}) do |artist, obj| obj[artist.name] = artists.count(artist) end
      artist_frequency_hash.sort_by do |key, value| value end.last.first
      else
        "No notes yet"
      end
  end

  def most_commented_on_song
    unless notes.empty?
      song_frequency_hash = songs.each_with_object({}) do |song, obj| obj[song.name] = songs.count(song) end
      song_frequency_hash.sort_by do |key, value| value end.last.first
      else
        "No notes yet"
      end
  end

  def most_commented_on_album
    unless notes.empty?
      album_frequency_hash = albums.each_with_object({}) do |album, obj| obj[album.name] = albums.count(album) end
      album_frequency_hash.sort_by do |key, value| value end.last.first
      else 
        "No notes yet"
      end
  end


end
