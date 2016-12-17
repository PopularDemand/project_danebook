module LikesHelper
  
  # TODO: "You" when current user likes
  def current_likes(likable)
    likes = likable.likes
    if likes.size < 3 && likes.size > 0
      names = likes.map { |like| like.liker.full_name }
      "#{names.join(" and ")} like this post"
    elsif likes.size > 2
      names = likes[0...2].map { |like| like.liker.full_name }
      "#{names.join(", ")} and #{pluralize((likes.size - 2), 'other')} like this post"
    end
  end

  def like_or_unlike(likable)
    # TODO refactor
      like = like_from_likable(likable)
      type = likable.class.to_s.downcase
    if like.empty?
      # TODO: make this polymorphic
      link_to 'Like', likable_likes_path(likable, :type => type), method: :post
    else
      # TODO: Way to just pass in like?
      link_to "Unlike", likable_like_path(likable, like, :type => type), method: :delete
    end
  end

  def like_from_likable(likable)
    Like.where("likable_id = ? AND likable_type = ? AND liker_id = ?", likable.id, likable.class, current_user.id)
  end
end
