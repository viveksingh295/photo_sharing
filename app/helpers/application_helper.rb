module ApplicationHelper

  def full_title(page_title = '')
    base_title = "Photo Sharing"
    if page_title.empty?
      base_title
    else
      page_title + " . " + base_title
    end
  end

  def posts_count
    Post.count
  end

end
