Showcase.ShowComponentsButtonGroupController = Ember.Controller.extend(
    options: ['Home', 'Profile', 'Messages']
    options2: ['Admin','Settings']
    optionsWithMeta: [
        Ember.Object.create({title: 'Create', type: 'primary'})
        Ember.Object.create({title: 'Destroy', type: 'danger'})
    ]
)