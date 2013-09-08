Showcase.ApplicationController = Ember.ArrayController.extend(
	actions:
	    select: (item) ->
	        @transitionToRoute item.route
)