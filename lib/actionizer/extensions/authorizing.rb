# Enables CanCan and compatible authorization to be used with actionizer.
#
# What's not supported currently: if you use `load_resource` or 
# `load_and_authorize_resource`, we don't use the instance(s) it sets.
module Actionizer
  module Extensions
    module Authorizing
      extend ::ActiveSupport::Concern
      Actionizer.available_extensions[:authorizing] = '::' + Authorizing.name

      # Scope query by @model_class.accessible_by(...).
      #
      # Note!: assumes that module includes will be done in such an order that
      # this method is executed before all others in the chain except the
      # one in the index module.
      def query_for_index
        @model_class.accessible_by(current_ability, params[:action].to_sym)
      end

    private

      def find_model_instance_with(the_params, first_sym)
        instance = super
        authorize! params[:action].to_sym, instance
      end

    end
  end
end
