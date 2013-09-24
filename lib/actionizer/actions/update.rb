module Actionizer
  module Actions
    module Update
      extend ::ActiveSupport::Concern

      ::Actionizer.available_actions[:update] = '::' + Update.name

      included do
        include ::Actionizer::Actions::Base
        include ::Actionizer::Actions::Common::Finders

        Array.wrap(self.autoincludes[:update]).each do |obj|
          case obj
          when Symbol
            begin
              include self.available_extensions[obj.to_sym].constantize
            rescue NameError => e
              raise "Could not resolve extension module. Check Actionizer/self.available_extensions[#{obj.to_sym.inspect}].constantize. Error: \n#{e.message}\n#{e.backtrace.join("\n")}"
            end
          when String
            begin
              include obj.constantize
            rescue NameError => e
              raise "Could not resolve extension module: #{obj}. Error: \n#{e.message}\n\n#{e.backtrace.join("\n")}"
            end
          else
            include obj
          end
        end
      end

      # The controller's update (put) method to update a resource.
      def update
        return catch(:action_break) do
          render_update perform_update(params_for_update)
        end || @action_result
      end

      def params_for_update
        __send__(@model_singular_name_params_sym)
      end

      def perform_update(the_params)
        record = find_model_instance!(the_params)
        record.update_attributes(the_params)
        instance_variable_set(@model_at_singular_name_sym, record)
      end

      def render_update(record)
        record.respond_to?(:errors) && record.errors.size > 0 ? render_update_invalid(record) : render_update_valid(record)
      end

      def render_update_invalid(record)
        render_update_valid(record)
      end

      def render_update_valid(record)
        respond_with record, (render_update_valid_options(record) || {}).merge(self.action_to_valid_render_options[:update] || {})
      end

      def render_update_valid_options(record)
        {}
      end
    end
  end
end
