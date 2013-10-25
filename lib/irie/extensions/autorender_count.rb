module Irie
  module Extensions
    # Standard rendering of index count in all formats except html so you don't need views for them.
    # This only works if include it after either/both include order/paging functions, since it overrides them.
    module AutorenderCount
      extend ::ActiveSupport::Concern
      ::Irie.available_extensions[:autorender_count] = '::' + AutorenderCount.name
      
      def render_index_count(count)
        logger.debug("Irie::Extensions::AutorenderCount.render_index_count(#{count.inspect})") if Irie.debug?
        @count = count
        respond_to do |format|
          format.html { render "#{params[:action]}_count" }
          format.any { render request.format.symbol => { count: count } }
        end
      end
      
    end
  end
end