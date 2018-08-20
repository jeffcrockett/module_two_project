class Album < ApplicationRecord
    belongs_to :artist
    has_many :songs
    has_many :lines, through: :songs 
    has_many :notes, through: :lines 
end
