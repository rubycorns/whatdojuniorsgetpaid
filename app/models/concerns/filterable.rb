module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(params)
      params.except(:controller, :action)
      results = self.all
      params.each do |key, value|
        results = results.where(key => value) if value.present?
      end
      results
    end
  end
end
