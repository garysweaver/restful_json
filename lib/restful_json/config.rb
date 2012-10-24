module RestfulJson
  CONTROLLER_OPTIONS = [
    :can_filter_by_default_using, 
    :debug, 
    :filter_split,
    :number_of_records_in_a_page,
    :predicate_prefix,
    :return_resource
  ]
  
  class << self
    CONTROLLER_OPTIONS.each{|o|attr_accessor o}
    alias_method :debug?, :debug
    def configure(&blk); class_eval(&blk); end
  end
end

RestfulJson.configure do
  self.can_filter_by_default_using = [:eq]
  self.predicate_prefix = '!'
  self.filter_split = ','
  self.number_of_records_in_a_page = 15
  self.return_resource = true
end
