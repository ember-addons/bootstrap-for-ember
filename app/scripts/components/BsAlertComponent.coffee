Bootstrap.BsAlertComponent = Ember.Component.extend(Bootstrap.TypeSupport,
    classNames: ['alert'],
    classNameBindings: ['fade', 'fade:in']
    layoutName: 'components/bs-alert'
    classTypePrefix: 'alert',
    attributeBindings: ['data-timeout']
    dismissAfter: 0
    closedParam: null

    didInsertElement: () ->
        if @dismissAfter > 0
            Ember.run.later(this, 'dismiss', @dismissAfter*1000);

        #This event is fired when the alert has been closed (will wait for CSS transitions to complete).
        Ember.$("##{@elementId}").bind('closed.bs.alert', () =>
            @sendAction('closed', @get('closedParam'))
            @destroy()
        )

        #This event fires immediately when the close instance method is called.
        Ember.$("##{@elementId}").bind('close.bs.alert', () =>
            @sendAction('close', @get('closedParam'))
        )

    dismiss: () ->
        Ember.$("##{@elementId}").alert('close')

)

Ember.Handlebars.helper 'bs-alert', Bootstrap.BsAlertComponent