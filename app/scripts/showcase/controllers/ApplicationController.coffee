Showcase.ApplicationController = Ember.ArrayController.extend(
    select: (item) ->
        @transitionToRoute item.route
)