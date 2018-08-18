class NotesController < ApplicationController
    before_action :set_note, only[:show, :edit, :update, :destroy]
end
