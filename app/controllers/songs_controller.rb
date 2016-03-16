class SongsController < ApplicationController
  before_action :set_song, only: [:edit, :update, :destroy]

  def index
    if current_user.admin?
      group_counts = Hash.new(0)
      User.all.each do |user|
        count = user.songs.count(competition_id:current_competition.id)
        group_counts[user.group_id.nil? ? "u#{user.id}" : "g#{user.group_id}"] += count
      end
      if group_counts.all? { |_,val| val == 2 }
        @songs = current_competition.songs.order('random()')
      end
    end
    @songs ||= current_user.songs.where(competition_id:current_competition.id)
  end

  def new
    @song = Song.new
  end

  def edit
  end

  def create
    song = current_user.songs.build(song_params)

    song.competition_id = current_competition.id

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
