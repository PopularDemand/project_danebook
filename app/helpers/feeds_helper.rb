module FeedsHelper

  def profile_pic_or_default(profile)
    unless profile.profile_pic == 'default_user.png'
      image_tag(profile.profile_pic.url(:thumb))
    else
      image_tag(profile.profile_pic, class: 'thumb')
    end
  end
end
