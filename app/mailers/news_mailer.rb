class NewsMailer < ActionMailer::Base
  default from: 'marian.vennewald@gds-medien.de'
  def news_email(newsletter)
    @aboNewsletter = AboNewsletter.all
    @newsletter = newsletter

    @aboNewsletter.each do |aboNewsletter|
      if(aboNewsletter.enable == true)
        @email = aboNewsletter.eMail
        mail :to=> @email,

          :subject=> "News-Mail"
      end
    end

  end
end