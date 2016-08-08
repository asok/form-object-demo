module FormObject
  extend ActiveSupport::Concern

  extend  ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  included do
    class_attribute :attribute_names
    class_attribute :model

    def self.define_attributes(model, *names)
      self.attribute_names = (attribute_names || []) + names.map(&:intern)
      self.model = model


      if Rails::VERSION::STRING > '5'
        cast_method = :cast
      else
        cast_method = :type_cast_from_user
      end

      attribute_names.each do |name|
        define_method name do
          @attributes ||= {}
          @attributes[name.intern]
        end

        define_method "#{name}=" do |v|
          @attributes ||= {}

          column = model.columns.find{ |c| c.name.intern == name }

          @attributes[name.intern] = if column
                                       model.connection.type_map.fetch(column.sql_type).send(cast_method, v)
                                     else
                                       v
                                     end
        end
      end
    end
  end

  def persisted?
    false
  end

  def errors_for(attribute)
    errors[attribute].join(', ') if errors.has_key?(attribute)
  end

  def assign_attributes(attributes)
    attributes.slice(*self.class.attribute_names).each do |name, value|
      send("#{name}=", value)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def persistable_attributes
    attributes.slice(*model.column_names.map(&:intern))
  end
end
