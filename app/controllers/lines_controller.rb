class LinesController < ApplicationController
    before_action :set_line, only: [:show]
    def show
      # @user = User.find_by(id: current_user_id)
    end

    private

    def set_line
        @line = Line.find(params[:id])
    end
end
