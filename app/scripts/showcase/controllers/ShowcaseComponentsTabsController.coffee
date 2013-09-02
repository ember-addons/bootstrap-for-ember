Showcase.ShowComponentsTabsController = Ember.Controller.extend(
    content: ['Home', 'Profile', 'Messages']

    init: () ->
        @._super()
        @set('selected', 'Home')

        @set('tabsPanesOptions', Ember.A([
            Ember.Object.create({ title: 'Foo', template: 'tabs/foo-tabpane'}),
            Ember.Object.create({ title: 'Bar', template: 'tabs/bar-tabpane'})
        ]))
)