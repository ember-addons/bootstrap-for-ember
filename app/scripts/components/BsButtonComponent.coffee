Bootstrap.BsButtonComponent = Ember.Component.extend(Bootstrap.TypeSupport, Bootstrap.SizeSupport,
    tagName: 'button'
    classNames: ['btn']
    classNameBindings: ['blockClass']
    classTypePrefix: 'btn'
    block: null
    attributeBindings: ['disabled', 'dismiss:data-dismiss']

    init: ->
        @_super()
        #If content is an object, then assign its properties to the button component
        if @get('content')? and Ember.typeOf(@get('content')) is 'object'
            for key,val of @get('content')
                @set key, val
        else
            @attributeBindings.pushObject attr for attr of @ when attr.match(/^data-\w*$/)?

    blockClass: ( ->
        if @block then "#{@classTypePrefix}-block" else null
    ).property('block').cacheable()

    click: ->
        @sendAction('clicked')

    loadingChanged: (->
        loading = if @get('loading') isnt null then @get('loading') else "reset"
        Ember.$("##{@elementId}").button(loading)
    ).observes('loading')
)
