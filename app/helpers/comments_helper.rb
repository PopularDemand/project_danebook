module CommentsHelper

  def delete_option(comment)
    if comment.commenter == current_user
      # <a href="#" class='delete-comment'>Delete</a>
      link_to "Delete", comment, method: :delete, class: 'delete-comment'
    end
  end
end
