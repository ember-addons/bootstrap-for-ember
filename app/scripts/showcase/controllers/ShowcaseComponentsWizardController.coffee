Showcase.ShowComponentsWizardController = Ember.Controller.extend(
    init: () ->
        @._super()

        @set('steps', Ember.A([
            Ember.Object.create({ title: 'Foo', template: 'tabs/foo-tabpane'}),
            Ember.Object.create({ title: 'Bar', template: 'tabs/bar-tabpane'}),
            Ember.Object.create({ title: 'Baz', template: 'tabs/baz-tabpane'})
        ]))
)