class SongsController < ApplicationController
  before_action :set_song, only: [:edit, :update, :destroy]

  def index
    @songs = current_user.id == 3 ? Song.order('random()') : current_user.songs
  end

  def new
    @song = Song.new
  end

  def edit
  end

  def create
    song = current_user.songs.build(song_params)
    song.upload(params[:song][:file]) if song.valid?

    if song.save
      redirect_to root_url, notice: "song added!"
    else
      render "new"
    end
  end

  def update
    @song.update_attributes(song_params)
    @song.upload(params[:song][:file]) if @song.valid?

    if @song.save
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
