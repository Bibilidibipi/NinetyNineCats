class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :logged_in, only: [:render_logout]

  helper_method :current_user, :current_session

  def current_user
    return nil if current_session.nil?
    @current_user ||= User.find(current_session.user_id)
  end

  def current_session
    return nil if session[:session_token].nil?
    @current_session ||= Session.find_by_session_token(session[:session_token])
  end

  def logged_in
    redirect_to new_session_url unless current_user
  end

  def login_user!(user)
    @current_session = Session.create!(user_id: user.id,
                                       session_token: Session.generate_session_token)
    session[:session_token] = @current_session.session_token
  end

  def render_logout
    render partial: 'layouts/logout'
  end

  def logout
    # unfortunately cannot zero out other browsers' sessions
    case params[:location]
    when 'here'
      current_session.try(:remove_session!)
      session[:session_token] = nil
    when 'elsewhere'
      current_user.sessions.each do |session|
        next if session.id == current_session.id
        session.try(:remove_session!)
      end
    else
      current_user.sessions.each { |session| session.try(:remove_session!) }
      session[:session_token] = nil
    end

    redirect_to cats_url
  end

  def redirect_cats
    redirect_to cats_url if current_user
  end
end
