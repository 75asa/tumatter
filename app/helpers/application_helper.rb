module ApplicationHelper
  # ページ毎の完全なタイトルを返す
  def full_title(page_title = '')
    base_title = "Tumatter"
    if page_title.empty?
      base_title
    else
      # page_title + " | " + base_title
      "#{page_title} | #{base_title}"
    end
  end
end
