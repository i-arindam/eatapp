class SimpleSerializer
  include ::SerializationModules

  delegate :attrs,
           :has_one_relations,
           :has_many_relations,
           :belongs_to_relations,
           :iso_timestamped_columns,
           to: :klass

  def initialize(base_object)
    @klass = self.class
    @base_object = base_object
  end

  def as_json
    return {} if base_object.blank?

    if base_object.is_a?(Array)
      base_object.map { klass.new(_1).as_json }
    else
      serialized_object
    end
  end

  private

  attr_accessor :klass, :base_object

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
      association_object = base_object.send(association_name)

      res[association_name] = association_serializer.new(association_object).as_json
    end
  end

  def massaged_attr(attr)
    attr_val = base_object.send attr

    attr.in?(Array.wrap(iso_timestamped_columns)) ? attr_val.iso8601 : attr_val
  end
end
