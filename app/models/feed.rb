class Feed

  def initialize(user)
    @user = user
  end

  def user_only
    # TODO don't cause timeouts. refactor into sql
    results = @user.posts.order(:created_at) + @user.photos.order(:created_at)

    results.sort { |item| item.created_at }
  end

  def all_friends
    # I am sorry, SQL gods
    results = @user.friends.map do |friend|
      friend.posts + friend.photos
    end

    results += @user.posts + @user.photos

    results.flatten.sort { |a,b| b.created_at <=> a.created_at }
  end

end