Showcase.ShowComponentsTabsPanesController = Ember.Controller.extend(
    tabsMeta: Ember.A([
        Ember.Object.create({ title: 'Foo', template: 'tabs/foo-tabpane', controller: 'ShowcaseComponentsTabsFoo'}),
        Ember.Object.create({ title: 'Bar', template: 'tabs/bar-tabpane'})
    ])
)