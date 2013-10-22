module Actionizer
  module Extensions
    module PathAndUrlHelpers

      # Defines edit url and path helper methods if they don't exist on include and
      # whenever the class is inherited.
      #
      # For self.collection_name="foos"/self.instance_name="foo"/FoosController, would create the following 
      # methods if they don't exist:
      # * edit_foo_path(*args, &block)
      # * edit_foo_url(*args, &block)
      module Edit
        extend ::ActiveSupport::Concern
        ::Actionizer.available_extensions[:edit_path_and_url] = '::' + Edit.name

        included do
          include ::Actionizer::ResourceDefinition
        end

        module ClassMethods

          def resource_defined
            define_edit_url_and_path_helpers
            super if defined?(super)
          end

          def define_edit_url_and_path_helpers
            unless instance_name
              # this might be normal if you intend to set configuration of the model later
              logger.debug("Actionizer::Extensions::PathAndUrlHelpers::Edit - self.instance_name not set yet, so will expect it to be set later and define_edit_url_and_path_helpers called after that, if needed.") if Actionizer.debug?
              return
            end

            controller_namespace = self.name.deconstantize.chomp('Controller').gsub('::','_').underscore
            controller_namespace += '_' if controller_namespace.size > 0
            
            instance_url_method = "edit_#{instance_name}_url".to_sym
            instance_path_method = "edit_#{instance_name}_path".to_sym
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
