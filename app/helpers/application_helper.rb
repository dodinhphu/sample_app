module ApplicationHelper
  include Pagy::Frontend
  def full_title page_title
    base_title = t("title")
    page_title.blank? ? base_title : page_title + " | " + base_title
  end
end
