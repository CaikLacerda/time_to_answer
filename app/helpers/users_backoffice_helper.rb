module UsersBackofficeHelper
  include Rails.application.routes.url_helpers

  def avatar_url
    if current_user.user_profile.avatar.attached?
      url_for(current_user.user_profile.avatar)
    else
      asset_path('undraw_profile.svg')
    end
  end  
end
