Showcase.ShowComponentsButtonGroupController = Ember.Controller.extend(
    options: ['Home', 'Profile', 'Messages']
    options2: ['Admin','Settings']
    optionsWithMeta: [
        {title: 'Create', type: 'primary'}
        {title: 'Destroy', type: 'danger'}
    ]
)