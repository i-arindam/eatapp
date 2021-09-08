module SerializationModules
  extend ActiveSupport::Concern

  module ClassMethods
    def iso_timestamp_columns(cols)
      @iso_timestamped_columns = cols
    end

    def attributes(*cols)
      @attrs = cols
    end

    def belongs_to(assoc, options)
      (@belongs_to_relations ||= []) << { assoc_name: assoc, serializer: options.fetch(:serializer) }
    end

    def has_one(assoc, options)
      (@has_one_relations ||= []) << { assoc_name: assoc, serializer: options.fetch(:serializer) }
    end

    def has_many(assoc, options)
      (@has_many_relations ||= []) << { assoc_name: assoc, serializer: options.fetch(:serializer) }
    end

    attr_accessor :base_object, :iso_timestamped_columns, :has_one_relations, :has_many_relations, :belongs_to_relations, :attrs
  end
end
