require 'active_support/concern'

module EnumAddons
  extend ActiveSupport::Concern

  included do
    self.defined_enums.each do |defined_enum, enum_values|
      define_method "#{defined_enum}_text" do
        self.class.human_attribute_name("#{defined_enum}.#{self.send(defined_enum)}")
      end

      singleton_class.class_eval do
        define_method("with_#{defined_enum}") do |value|
          where("? = ?", defined_enum, enum_values[value.to_s])
        end

        define_method("#{defined_enum}_values") do
          enum_values.to_a.map do |enum_item|
            translated_item = self.human_attribute_name("#{defined_enum}.#{enum_item[0]}")
            [translated_item, enum_item[0]]
          end
        end
      end 
    end
  end
end
