Bootstrap.BsPanelComponent = Ember.Component.extend(Bootstrap.TypeSupport,
    classNames: ['panel']
    classTypePrefix: 'panel'
    clicked: null
    onClose: null

    click: (event) ->
        event.preventDefault()

        targetDimiss = event.target.getAttribute 'data-dismiss'
        if targetDimiss is 'panel'
            @sendAction('onClose')
            @destroy()
        else
            @sendAction('clicked')
)