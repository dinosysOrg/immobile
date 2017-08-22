module Sortby
  extend ActiveSupport::Concern

  def sort_by
    sort_by = 'created_at DESC'
    if params[:sort_by].present?
      sort_by = params[:sort_by].to_s
      if params[:asc].present? && params[:asc].to_s == 'false'
        sort_by += ' DESC'
      else
        sort_by += ' ASC'
      end
    end
    sort_by
  end
end
