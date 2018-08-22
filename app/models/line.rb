class Line < ApplicationRecord
    belongs_to :song, optional: true
    has_many :notes
end

    
