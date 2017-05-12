class RoomsController < ApplicationController

  respond_to :json

  before_action :set_room, only: [:show, :destroy, :roomUpdate, :roomEdit]
  before_action :set_event, only: [:edit, :update, :deleteEvent]

  def neu
    @room = Room.new
    respond_to do |f|
      f.html
    end
  end


  def roomEdit
    respond_to do |f|
      f.html
    end
  end

  def roomUpdate
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to action: "angular", notice: "Raumdaten wurde erfolgreich verändert" }
      end
    end
  end

  def angular

    #@rooms = Room.all
    render 'rooms/index'
  end

  def calendar
    @id = params[:id]
    respond_to do |f|
      f.html
    end
  end

  def angularNew
    @id = params[:id]
    render 'rooms/new'
  end

  def neuEvent
    @rooms = Room.all
    @users = User.with_role(:event)
    render'rooms/neuEvent'
  end

  def showMembers
    render 'rooms/event'
  end

  # GET /rooms
  # GET /rooms.json
  def index
   # @rooms = Room.all
    respond_to do |format|
      format.json { render json: Room.order(:building)}

    end
  end

  def show
    render 'rooms/show'
  end

  def new
    @room = Room.new
  end

  def edit
    @id = params[:id]
    @accounts = Account.where(accountName: @c_event.accountName)
    @documents = []
    @allDocuments = Resume.all
    @accounts.each do |d|
      @resume = Resume.find(d.resume_id)
      @documents.push({:id => d.resume_id, :name => @resume.name, :url => @resume.attachment_url, :accountId => d.id})
    end
    respond_to do |f|
      f.html
    end
  end

  def addDoc
    @event = CEvent.find(params[:id])
    @resume = Resume.new(doc_params)
    @resume.save
    @account = Account.new
    @account.accountName = @event.accountName
    @account.resume_id = @resume.id
    @account.save
    redirect_to "/administrator/rooms/event/" + params[:id]
  end
  def addDocWithExist
    @event = CEvent.find(params[:id])
    @account = Account.new
    @account.accountName = @event.accountName
    @account.resume_id = doc_exist_params[:resume_id]
    @account.save
    redirect_to "/administrator/rooms/event/" + params[:id]
  end

  def create
    @room = Room.new(room_params)
    respond_to do |format|
      if @room.save
        format.html { redirect_to action: "angular", notice: "Raum wurde erfolgreich hinzugefügt" }
      else
        format.html { redirect_to action: "neu" }
        format.json { render json: @room.errors, status: :unprocessable_entity }

      end
    end
  end

  def roomCreate
    @room = Room.new(room_params)
    respond_to do |format|
      if @room.save
        format.html { redirect_to action: "angular", notice: "Raum wurde erfolgreich hinzugefügt" }
      end
    end
  end

  def update
    @c_event.title = c_event_params[:title]
    @c_event.description = c_event_params[:description]
    @c_event.minSize = c_event_params[:minSize]
    @c_event.maxSize = c_event_params[:maxSize]
    @startdateOne = c_event_params[:dateOne] + " " + c_event_params[:starttimeOne]
    @enddateOne = c_event_params[:dateOne] + " " + c_event_params[:endtimeOne]
    @c_event.start =  @startdateOne.to_time.strftime("%Y-%m-%d %k:%M:%S")
    @c_event.end = @enddateOne.to_time.strftime("%Y-%m-%d %k:%M:%S")
    if(c_event_params[:dateTwo] != "")
      @startdateTwo = c_event_params[:dateTwo] + " " + c_event_params[:starttimeTwo]
      @enddateTwo = c_event_params[:dateTwo] + " " + c_event_params[:endtimeTwo]
      @c_event.startSecond = @startdateTwo.to_time.strftime("%Y-%m-%d %k:%M:%S")
      @c_event.endSecond = @enddateTwo.to_time.strftime("%Y-%m-%d %k:%M:%S")
    end
    if(c_event_params[:dateThree] != "")
      @startdateThree = c_event_params[:dateThree] + " " + c_event_params[:starttimeThree]
      @enddateThree = c_event_params[:dateThree] + " " + c_event_params[:endtimeThree]
      @c_event.startThird = @startdateThree.to_time.strftime("%Y-%m-%d %k:%M:%S")
      @c_event.endThird = @enddateThree.to_time.strftime("%Y-%m-%d %k:%M:%S")
    end

    @c_event.startLogin = c_event_params[:startLogin].to_time.strftime("%Y-%m-%d %k:%M:%S")
    @c_event.endLogin = c_event_params[:endLogin].to_time.strftime("%Y-%m-%d %k:%M:%S")

    if @c_event.save

      @members = Member.where(event_id: @c_event.id).where(accept: 1)
      @members.each do |member|
        @member = member
        ContactMailer.change_event(@member, @c_event).deliver
      end
    end
    redirect_to :action => "calendar", :id => @c_event.room_id
  end

  def destroy
    @events = CEvent.where(room_id: params[:id])
    @events.each do |event|
      @accounts = Account.where(accountName: event.accountName)
      @accounts.destroy_all
    end
    @events.destroy_all
    @room.destroy
    redirect_to :action => "angular"
  end

  def deleteEvent
    @id = @c_event.room_id
    @accounts = Account.where(accountName: @c_event.accountName)
    @accounts.destroy_all
    @c_event.destroy
    redirect_to :action => "calendar", :id => @id
  end

  def destroyDocument
    @account = Account.find(params[:id])
    @event = CEvent.where(accountName: @account.accountName).last
    @account.destroy

    redirect_to "/administrator/rooms/event/" + @event.id.to_s
  end

  private
  # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end
    def set_event
      @c_event = CEvent.find(params[:id])
    end
    def c_event_params
      params.require(:c_event).permit(:title, :dateOne, :starttimeOne, :endtimeOne, :dateTwo, :starttimeTwo, :endtimeTwo, :dateThree, :starttimeThree, :endtimeThree, :dateL,:startLogin, :endLogin, :color, :description, :room_id, :minSize, :member, :maxSize, :free)
    end

    def doc_params
      params.require(:doc).permit(:name, :attachment)
    end

    def doc_exist_params
      params.require(:docExist).permit(:resume_id)
    end
    def room_params
      params.require(:room).permit(:number, :size, :building)
    end
end

