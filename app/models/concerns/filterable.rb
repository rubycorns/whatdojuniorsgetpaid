module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(params)
      results = self.all
      params.each do |key, value|
        if results.column_names.include? key
          results = results.where(key => value) if value.present?
        end
      end
      results
    end
  end
end
