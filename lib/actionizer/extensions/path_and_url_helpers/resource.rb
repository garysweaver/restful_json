module Actionizer
  module Extensions
    module PathAndUrlHelpers

      # Defines resource url and path helper methods if they don't exist on include and
      # whenever the class is inherited.
      #
      # For self.collection_name="foos"/self.instance_name="foo"/FoosController, would create the following 
      # methods if they don't exist:
      # * foo_path(*args, &block)
      # * foo_url(*args, &block)
      module Resource
        extend ::ActiveSupport::Concern
        ::Actionizer.available_extensions[:resource_path_and_url] = '::' + Resource.name

        included do
          include ::Actionizer::ResourceDefinition
        end

        module ClassMethods

          def resource_defined
            logger.debug("Actionizer::Extensions::PathAndUrlHelpers::Resource.resource_defined") if Actionizer.debug?
            define_edit_url_and_path_helpers
            super if defined?(super)
          end

          def define_resource_url_and_path_helpers
            logger.debug("Actionizer::Extensions::PathAndUrlHelpers::Resource.define_resource_url_and_path_helpers") if Actionizer.debug?
            unless self.instance_name
              # this might be normal if you intend to set configuration of the model later
              logger.debug("Actionizer::Extensions::PathAndUrlHelpers::Resource - self.instance_name not set yet, so will expect it to be set later and define_resource_url_and_path_helpers called after that, if needed.") if Actionizer.debug?
              return
            end

            controller_namespace = self.name.deconstantize.chomp('Controller').gsub('::','_').underscore
            controller_namespace += '_' if controller_namespace.size > 0
            
            instance_url_method = "#{self.instance_name}_url".to_sym
            instance_path_method = "#{self.instance_name}_path".to_sym
            unless controller_namespace.size == 0
              self.class_eval "def #{instance_url_method}(*args, &block);#{controller_namespace}#{instance_url_method}(*args, &block);end"
              self.class_eval "def #{instance_path_method}(*args, &block);#{controller_namespace}#{instance_path_method}(*args, &block);end"
            end
          end
        
        end
      end
    end
  end
end
