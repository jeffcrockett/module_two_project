class NotesController < ApplicationController
    before_action :set_note, only: [:show, :edit, :update, :destroy]

    def new
    end

    def create
        @note = Note.create(note_params)
        redirect_to line_path(@note.line)
    end

    def edit
        @line = @note.line
    end

    def update
        @note.update(note_params)
        if @note.save
            redirect_to line_path(@note.line)
        else
            redirect_to edit_note_path(@note)
        end
    end

    def destroy
        line = @note.line
        @note.destroy
        redirect_to song_path(line.song)
    end

    private

    def set_note
        @note = Note.find(params[:id])
    end

    def note_params
        params.require(:note).permit(:name, :line_id, :user_id)
    end

end
