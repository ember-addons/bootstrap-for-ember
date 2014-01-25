Showcase.ShowComponentsItemsActionBarController = Ember.Controller.extend(
    actionsInBar: [
        [
            {
                title: 'To Alerts',
                #return true if action should be disabled, this method is invoked whenever the selection is changed.
                disabled: (selection) ->
                    true if selection.size < 1 || selection?[0]?.title isnt 'Alerts'
                #transition to some route when action is clicked
                transitionTo: 'show_components.alert'
            },
            {
                title: 'To Panels',
                transitionTo: 'show_components.panel'
                disabled: (selection) ->
                    true if selection.size < 1 || selection?[0]?.title isnt 'Panels'
            }
        ]
        [
            {
                title: 'To Wizard',
                disabled: (selection) ->
                    true if selection.size < 1 || selection?[0]?.title isnt 'Wizards'
                #invoke a controller action when action is clicked
                clickActionName: 'wizard'
            }
        ]
    ]

    actions:
        wizard: (selection) ->
            alert "Wizard pressed!"

    items: [
        Ember.Object.create({title: 'Alerts'}),
        Ember.Object.create({title: 'Panels'}),
        Ember.Object.create({title: 'Wizards'})
    ]
)