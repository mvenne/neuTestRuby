class CardsController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    #  @events = CEvent.where(start: params[:start]..params[:end])
    #@c_events = CEvent.all
    respond_to do |format|
#      format.json { render json: CEvent.where(room_id: params[:roomid])}
    end
  end

  def booking

  end


  def show
    respond_to do |format|
      #     format.json { render json: Member.where( event_id: params[:id]) }
    end
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = Card.new(card_params)
    @articles = params[:articles]
    # TODO Tests
    # @c_event.userMail = current_user.email
    @card.save
  end

  def update
    @card.update(article_params)
  end

  def destroy
    @card.destroy
  end

  private

  def set_article
    @card = Card.find(params[:id])
  end



  def card_params
    params.require(:card).permit(:name, :vorname, :einrichtung, :adresse, :ort, :email)
  end
end