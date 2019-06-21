class ContactsController < ApplicationController
  include LatestContents
  before_action -> { latest_news(2) } , only: [:index]

  def index
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      NoticeMailer.contact_email(@contact).deliver_later
      redirect_to thanks_path, notice: t("contact_was_successfully_created")
    else
      render :index
    end
  end

  private
    def contact_params
      params.require(:contact).permit(
        :name,
        :company_name,
        :email,
        :telephone,
        :address,
        :description)
    end
end
