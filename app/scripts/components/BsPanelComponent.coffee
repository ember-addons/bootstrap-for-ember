Bootstrap.BsPanelComponent = Ember.Component.extend(Bootstrap.TypeSupport,
    classNames: ['panel']
    classTypePrefix: ['panel']
    classNameBindings: ['fade', 'fade:in']
    clicked: null
    onClose: null
    fade: true
    collapsible: false
    open: true

    close: (event) ->
        @sendAction('onClose')
        @$().removeClass('in')
        #TODO: Causes ' Object #<HTMLDivElement> has no method 'destroyElement' '
        #@$().one($.support.transition.end, @destroy).emulateTransitionEnd(150)
        #Workaround
        setTimeout (->
            @destroy()
        ).bind(@), 250

    collapsibleBodyId: (->
        "#{@get('elementId')}_body"
    ).property('collapsible')

    collapsibleBodyLink: (->
        "##{@get('elementId')}_body"
    ).property('collapsibleBodyId')
)