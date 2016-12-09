module LikesHelper

  def like_or_unlike(likable)
    # TODO refactor
      like = like_from_likable(likable)
    if like.empty?
      # TODO: make this polymorphic
      link_to "Like", post_likes_path(likable), method: :post
    else
      # TODO: Way to just pass in like?
      link_to "Unlike", post_like_path(likable, like), method: :delete
    end
  end

  def like_from_likable(likable)
    Like.where("likable_id = ? AND likable_type = ? AND liker_id = ?", likable.id, likable.class, current_user.id)
  end
end
