module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(params)
      results = self.all
      params.each do |key, value|
        results = results.where(key => value) if value.present?
      end
      results
    end
  end
end
