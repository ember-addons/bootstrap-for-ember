Showcase.ShowComponentsTabsController = Ember.Controller.extend(
    content: ['Home', 'Profile', 'Messages']

    init: () ->
        @._super()
        @set('selected', 'Home')
)