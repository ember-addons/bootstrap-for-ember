Showcase.UserController = Ember.Controller.extend(
    tabsMeta: [
        Ember.Object.create({ title: 'General', linkTo: 'user.general'})
        Ember.Object.create({ title: 'Privacy', linkTo: 'user.privacy'})
        Ember.Object.create({ title: 'Activities', linkTo: 'user.activities'})
    ]
)
