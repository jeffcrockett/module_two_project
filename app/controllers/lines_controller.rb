class LinesController < ApplicationController
    before_action :set_line, only: [:show]
    def show
    end

    private 
    
    def set_line 
        @line = Line.find(params[:id])
    end
end
