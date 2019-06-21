module ApplicationHelper
  def truncate_description(description)
    strip_tags(description.gsub(/\r\n|\r|\n|\s|\t/, "")).truncate(200)
  end
end
