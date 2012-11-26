module ApplicationHelper
  def set_title(value)
    content_for(:title, value)
    response.headers['X-Title'] = value if request.headers['X-Slide'].present?
  end
end
