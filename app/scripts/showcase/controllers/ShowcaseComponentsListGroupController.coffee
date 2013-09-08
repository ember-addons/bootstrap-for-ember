Showcase.ShowComponentsListGroupController = Ember.Controller.extend(
    listSimple: Ember.A(['Cras justo odio', 'Dapibus ac facilisis in', 'Morbi leo risus'])
    listWithBadges: Ember.A([
        Ember.Object.create({title: 'Inbox', badge: '45'})
        Ember.Object.create({title: 'Sent', badge: '33'})
    ])

    listWithSub: Ember.A([
        Ember.Object.create({title: 'Inbox', sub: 'Incoming mails folder', badge: '45'})
        Ember.Object.create({title: 'Sent', sub: 'Sent emails folder', badge: '33'})
    ])
)