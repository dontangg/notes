class SongsController < ApplicationController
  before_action :set_song, only: [:edit, :update, :destroy]

  def index
    @songs = current_user.songs
  end

  def new
    @song = Song.new
  end

  def edit
  end

  def create
    sub = current_user.songs.build(song_params)
    if sub.save
      redirect_to root_url, :notice => "song added!"
    else
      render "new"
    end
  end

  def update
    if @song.update(song_params)
      redirect_to songs_url, notice: 'song was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @song.destroy
    redirect_to songs_url
  end


  private

  def set_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song)
      .permit(
        :name,
        :artist,
      )
  end
end
