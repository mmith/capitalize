module Capitalize
  def self.included(base)
    base.send :extend, ClassMethods
  end
  
  module ClassMethods
    def acts_as_capitalize *args
      write_inheritable_attribute(:capitalize_array, args)
      class_inheritable_reader :capitalize_array
      
      before_save :capitalize_fields
      
      send :include, InstanceMethods
    end
  end
  
  module InstanceMethods
    def capitalize_fields
      capitalize_array.each do |field|
        self.send(field.to_s+'=',self.send(field.to_s).capitalize) unless self.send(field.to_s).nil?
      end
    end
  end
end

ActiveRecord::Base.send :include, Capitalize