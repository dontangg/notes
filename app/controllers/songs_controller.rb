class SongsController < ApplicationController
  before_action :set_song, only: [:edit, :update, :destroy]

  def index
    competition = Competition.find_by(active:true)
    # TODO: allow a specific user to see all the songs once all the songs have been submited to upload them
    @songs = current_user.id == 3 ? competition.songs.order('random()') : current_user.songs.where(competition_id:competition.id)
    #@songs = current_user.songs.where(competition_id:competition.id)
  end

  def new
    @song = Song.new
  end

  def edit
  end

  def create
    song = current_user.songs.build(song_params)

    competition = Competition.find_by(active:true)
    song.competition_id = competition.id

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
