Showcase.ShowComponentsPillsController = Ember.Controller.extend(
    content: ['Home', 'Profile', 'Messages']

    init: () ->
        @._super()
        @set('content1', Ember.A([
            Ember.Object.create({ title: 'Home', default: true, disabled: false }),
            Ember.Object.create({ title: 'Admin', disabled: true })
        ]))

        @set('selected1', @get('content1').objectAt(0))

    contentChanged: (->
        console.log("Selection has changed to: #{@get('selected')}")
    ).observes('selected')

    actions:
        disableHome: () ->
            @get('content1').objectAt(0).set('disabled', true)
)