module ApplicationHelper
  SITE_NAME = 'Baukis2'.freeze
  def document_title
    if @title.present?
      "#{@title} - #{SITE_NAME}"
    else
      SITE_NAME
    end
  end
end
