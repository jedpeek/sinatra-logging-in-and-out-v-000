class Helpers

  def current_user(session)
    User.all.each do |user|
      if user.id == session[:id]
        return user
      end
    end
  end

  def is_logged_in?(session)
    !!session[:id]
  end
end
