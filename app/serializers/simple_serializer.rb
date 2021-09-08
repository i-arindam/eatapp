class SimpleSerializer
  include ::SerializationModules

  delegate :attrs,
           :has_one_relations,
           :has_many_relations,
           :belongs_to_relations,
           :iso_timestamped_columns,
           to: :klass

  def initialize(object)
    @klass = self.class
    @object = object
  end

  def as_json
    return {} if object.blank?

    if object.is_a?(Array)
      object.map { klass.new(_1).as_json }
    else
      serialized_object
    end
  end

  private

  attr_accessor :klass, :object

  def serialized_object
    Hash.new.merge(attributes_values).merge(association_values)
  end

  def attributes_values
    attrs.each_with_object({}) do |attr, res|
      res[attr] = massaged_attr(attr)
    end
  end

  def association_values
    Hash.new
      .merge(serialize_associations(belongs_to_relations))
      .merge(serialize_associations(has_one_relations))
      .merge(serialize_associations(has_many_relations))
  end

  def serialize_associations(relations)
    Array.wrap(relations).each_with_object({}) do |relation, res|
      association_name = relation[:assoc_name]
      association_serializer = relation[:serializer]
      association_object = value(association_name)

      res[association_name] = association_serializer.new(association_object).as_json
    end
  end

  def massaged_attr(attr)
    attr_val = value(attr)

    attr.in?(Array.wrap(iso_timestamped_columns)) ? attr_val.iso8601 : attr_val
  end

  def value(name)
    if self.respond_to?(name)
      self.public_send(name)
    else
      object.public_send(name)
    end
  end
end
