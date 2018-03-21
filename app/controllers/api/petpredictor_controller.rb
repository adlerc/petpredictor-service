module Api
  class PetpredictorController < ApplicationController

    def index
      rawstat = RawStat.where(height: params[:height]).where(weight: params[:weight]).take
      dogorcat = rawstat == nil || rawstat.dog_count == rawstat.cat_count ? rand(2) : rawstat.dog_count > rawstat.cat_count ? 0 : 1
      guess = Guess.new(params[:height],params[:weight], dogorcat)
      render json: guess, status: 200
    end 

    def create
      rawstat = RawStat.where(height: stats_params[:height]).where(weight: stats_params[:weight]).take
      if rawstat != nil
        rawstat.dog_count += stats_params[:dog_count].to_i
        rawstat.cat_count += stats_params[:cat_count].to_i
        rawstat.save
        render nothing: true, status: 204
      else
        rawstat = RawStat.new(height: stats_params[:height],weight: stats_params[:weight], dog_count: stats_params[:dog_count], cat_count: stats_params[:cat_count])
        rawstat.save
        render json: rawstat, status: 201
      end
    end

    private
      def stats_params
        params.require(:raw_stats).permit(:height, :weight, :dog_count, :cat_count)
      end
  end
end
