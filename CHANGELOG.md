## Irie 1.0.3 ##

* Conditionally monkey patch deep_dup for Rails 3.2 support.

## Irie 1.0.2 ##

* Debug log message fix.

## Irie 1.0.1 ##

* Caches resource in query includes to avoid additional query(ies). Thanks to Tommy for noticing!

## Irie 1.0.0 ##

* Renamed restful_json to Irie. It isn't only about json.

Changes since restful_json v4.5.1:

* Now assumes Rails 4+ and uses Inherited Resources.
* Simplification of configuration, usage, and implementation.
* CanCan/authR support now optional via authorizer module.
* Removed direct support for Permitters. The controller can define params methods and/or use `before_action`.
* Removed direct support for ActiveModel::Serializers. The controller can define serializer(s) in `valid_render_options`.
* Removed exception handlers so can use default Rack exception handling or `rescue_from`.
* Authorization support handled via separate module using `before_action`.
* Added action-specific validation error handling methods.
* Added `can_order_by`.
* Renamed `order_by` to `default_order_by` to clarify intent.
* Removed `:with_default` option from `can_filter_by` and replaced with method `default_filter_by`, because it is unlikely the same default value would be used with multiple predicates.
* `valid_render_options` is now the way to specify render options.
* Split action behavior into more methods to be easily overrideable.
* Removed `query_for` index action copying behavior and replaced with `index_query`.
* Removed `with_query` on `can_filter_by` and replaced with method `can_filter_by_query`.
* No longer send (t) into query lambdas. If you need it in the lambda, use `resource_class.arel_table`.
* Can rename or alias the request parameter names used for functions to avoid conflicts with attributes.
* Renamed functions to match relational counterpart: uniq -> distinct, skip -> offset, take -> limit.
* Predicate prefix is now `.` instead of `!`.
* Must intentionally include action methods, e.g. `include_actions :all`.
* `supports_functions` replaced with intentionally include extension modules, e.g. `include_extensions :paging, :order` like `supports_functions`. However, `autoincludes` allows similar behavior before by automatically including configurable sets of modules for features that don't really do anything unless you call their class methods to configure.
* Added self.update_should_return_entity to config.
* Changed model class and name related variables resource_class, collection_name, instance_name methods, similar to inherited_resources.
* Allow ability to get resource_class, etc. on controller class vs. only instance.
* Added debug option to enable debug logging in instance methods to help track execution without tracing/debugging.
* Config errors now Irie::ConfigurationError.
* Rework of url and path helpers.
* Support for configuring model-related attributes via `default` method with options somewhat similar to inherited_resources.
* `can_filter_by` delimiting is now specified as an option `:split` in the `can_filter_by`.
* Probably many other changes. See the README.

## restful_json 4.5.1 ##

* Changed `render_error` method name to `render_rj_action_error` to avoid Rails conflict.

## restful_json 4.5.0 ##

* Changed config: `rescue_handlers` -> `rj_action_rescue_handlers`, `rescue_class` -> `rj_action_rescue_class` to avoid conflicts with rescue_from.

## restful_json 4.4.0 ##

* Fix for "The method `.includes()` must contain arguments." Now does not call includes on the relation if empty.
* Added `clean_backtrace` option to not clean backtraces in `error_data` if using `error_handlers`.
* Fixing Strong Parameters support for `(model name)_params` private method in Ruby 1.9.3/2.0.0.
* If using Strong Parameters, create/update now defaults to looking for `(model name)_params` method in controller.
 
## restful_json 4.3.1 ##

* Fix for including/includes_for
* No longer building for Rails 3.1.
* Documented workarounds for errors caused by including/includes_for; in some cases, incorrect SQL generated by Rails/AR when mix with joins for same tables.

## restful_json 4.3.0 ##

* Made `serialize_action` callable twice; once for array serializer and once for each serializer, for array actions.
* Added `additional_render_or_respond_success_options` and `default_additional_render_or_respond_success_options` to allow custom logic for determination of serializers for an action.
* Added `model_class_scoped` method to return `@model_class.all` or `@model_class.scoped` to hurdle deprecation.

## restful_json 4.2.0 ##

* Added `includes_for` class method in controller to help avoid n+1 queries via calling `.includes(...)` for a specific action.
* Added `apply_includes_to_custom_queries` to config.

## restful_json 4.1.0 ##

* Added `including` class method in controller to help avoid n+1 queries via calling `includes(...)`.

## restful_json 4.0.0 ##

* Extracted permitters into separate gem with some changes. See Permitters project.
* Added `action_to_permitter`, `actions_that_authorize`, `allow_action_specific_params_methods`, and `actions_that_permit` to config.

## restful_json 3.4.2 ##

* Removing `rescue_from`'s from DefaultController that would require additional controller methods if default error handling not used.

## restful_json 3.4.1 ##

* Try to require 'active_record/errors' before referring to `ActiveRecord::RecordNotFound` in gem default config.
* Don't add permitters to autoload path if RestfulJson.use_permitters is false in environment or initializer.
* Railtie that adds deprecated `acts_as_restful_json` support now being required.
* Added activesupport runtime dependency to gemspec.
* Missing i18n key now defaults to error.message.

## restful_json 3.4.0 ##

* Added `rescue_class` config option to indicate highest level class to rescue for every action. (nil/NilClass indicates to re-raise StandardError.)
* Added `rescue_handlers` config option as substitute for having to rescue, log, set status and i18n message key for sets of exceptions.
* Added `return_error_data` config option to also return the exception's class.name, class.message, and class.backtrace (cleaned) in "error_data" in error response.

## restful_json 3.3.4 ##

* If debug config option true, controller/app will now log debug to Rails logger.
* Fixing bug: will return head: ok with no body on destroy for no errors in formats other than HTML, like it did in versions before restful_json v3.3.0.

## restful_json 3.3.3 ##

* Using `.where(id: params[:id].to_s).first` in show/update/destroy, `.where(id: params[:id].to_s).first!` in edit.
* No more deprecated `find(id)` in show/edit.

## restful_json 3.3.2 ##

* Removed unnecessary debug logging of permitter class, and now only outputs if can't find when debug on.

## restful_json 3.3.1 ##

* Update and destroy use where instead of find and update 404's for missing record.
* Important fixes to recommendations around use of modules in doc.
* Removed unnecessary debug logging of serializer.

## restful_json 3.3.0 ##

* Added `avoid_respond_with` config option to always use render instead of `respond_with`.
* Fixing bug in `serialize_action`.
* Consolidated controller rendering.
* Better isolated controller and model changes, made model changes for Cancan and Strong Parameters something that needs to be done in configuration.
* Tests for Rails 3.1, 3.2, 4.

## restful_json 3.2.2 ##

* Fixing bug in `order_by`.
* Working on travis-ci config and appraisals/specs for testing Rails 3.1/3.2/4.0.

## restful_json 3.2.1 ##

* Important change to README that should not use `acts_as_restful_json` in parent/ancestor class shared by multiple controllers, because it is unsafe.
* Fixing bug in delete related to custom serializer when using AMS.

## restful_json 3.2.0 ##

* Made ActiveModel::Serializers, Strong Parameters, Permitters, Cancan all optional.
* Added support for strong_parameters without Permitters/Cancan, allowing *_params methods in controller.
* Fixing double rendering bug on create in 3.1.0.

## restful_json 3.1.0 ##

* Added ActiveModel::Serializers custom serializer per action(s) support.
* Added JBuilder support.
* Fixing gemspec requirements to not include things it shouldn't.

## restful_json 3.0.1 ##

* Updated `order_by`, comments.

## restful_json 3.0.0 ##

* Controller with declaratively configured RESTful-ish JSON services, filtering, custom queries, actions, etc. using strong parameters, a.m. serializers, and Adam Hawkins (twinturbo) permitters
