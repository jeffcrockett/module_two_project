class Song < ApplicationRecord
    belongs_to :album, optional: true
    has_many :lines
    has_many :notes, through: :lines

    def artist
        album ? album.artist : nil 
    end

    def all_words
        lines.map do |line| line.name.downcase.gsub(/[!',\.]/, '').split(' ') end.flatten
    end

    def word_count
        all_words.length
    end

    def words_ratio
        all_words.uniq.length / word_count
    end

    def self.longest
        self.all.sort_by do |song| song.word_count end.last
    end


end
