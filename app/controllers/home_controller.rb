class HomeController < BasicAuthController
  def index
  end

  def contact
  end

  def send_contact
    ContactMailer.contact(params[:contact][:name], params[:contact][:email], params[:contact][:subject], params[:contact][:message]).deliver_now
    # render 'send_contact'
  end

  def about
  end
end
