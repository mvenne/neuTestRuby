class AboNewslettersController < ApplicationController
  before_action :set_abo_newsletter, only: [:show, :edit, :update, :destroy]

  # GET /abo_newsletters
  # GET /abo_newsletters.json
  def index
    @abo_newsletters = AboNewsletter.all
  end

  # GET /abo_newsletters/1
  # GET /abo_newsletters/1.json
  def show
  end

  # GET /abo_newsletters/new
  def new
    @abo_newsletter = AboNewsletter.new
    @newsletter = NewsContent.all
  end

  # GET /abo_newsletters/1/edit
  def edit
  end

  # POST /abo_newsletters
  # POST /abo_newsletters.json
  def create
    @abo_newsletter = AboNewsletter.new(abo_newsletter_params)
    @abo_newsletter.enable = false

    respond_to do |format|
      if @abo_newsletter.save
        # TODOO Email link zum anmelden
        NewsMailer.anmelden_email(@abo_newsletter).deliver
        flash[:info] = 'Bitte bestätigen Sie in der kommenden Mail Ihre Identität.'
        format.html { redirect_to "/abo_newsletters/new" }
      else
        flash[:error] = 'Fehler beim Abonieren des Newsletters. Bitte wenden Sie sich an vkm-rwl, oder versuchen Sie es erneut.'
        format.html { redirect_to "/abo_newsletters/new" }
      end
    end
  end

  # PATCH/PUT /abo_newsletters/1
  # PATCH/PUT /abo_newsletters/1.json
  def update
    respond_to do |format|
      if @abo_newsletter.update(abo_newsletter_params)
        format.html { redirect_to @abo_newsletter, notice: 'Abo newsletter was successfully updated.' }
        format.json { render :show, status: :ok, location: @abo_newsletter }
      else
        format.html { render :edit }
        format.json { render json: @abo_newsletter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /abo_newsletters/1
  # DELETE /abo_newsletters/1.json
  def destroy
    @abo_newsletter.destroy
    respond_to do |format|
      flash[:success] = 'Ihr Abo wurde erfolgreich gelöscht.'
      format.html { redirect_to @abo_newsletters_url }
      format.json { head :no_content }
    end
  end

  # Get /abo_newsletter/email/signOut
  def signOutNews
    @abo_newsletter = AboNewsletter.find(params[:email])
    @abo_newsletter.enable = false
    respond_to do |format|
      if @abo_newsletter.save
        flash[:success] = 'Ihr Abo für den Newsletter wurde erfolgreich abgemeldet.'
        format.html { redirect_to "/abo_newsletters/new" }
      else
        flash[:error] = 'Ihr Abo für den Newsletter wurde nicht abgemeldet. Bittte wenden Sie sich an vkm-rwl'
        format.html { redirect_to "/abo_newsletters/new" }
      end
    end
  end

  def signInNews
    @abo_newsletter = AboNewsletter.find(params[:id])
    @abo_newsletter.enable = true
    respond_to do |format|
      if @abo_newsletter.save
        flash[:success] = 'Ihr Abo für den Newsletter wurde erfolgreich angemeldet.'
        format.html { redirect_to "/abo_newsletters/new" }
      else
        flash[:error] = 'Ihr Abo für den Newsletter wurde nicht angemeldet. Bitte wenden Sie sich an vkm-rwl'
        format.html { redirect_to "/abo_newsletters/new" }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_abo_newsletter
      @abo_newsletter = AboNewsletter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def abo_newsletter_params
      params.require(:abo_newsletter).permit(:eMail, :enable)
    end
end
