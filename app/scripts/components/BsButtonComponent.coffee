Bootstrap.BsButtonComponent = Ember.Component.extend(Bootstrap.TypeSupport, Bootstrap.SizeSupport,
    layoutName: 'components/bs-button'
    tagName: 'button'
    classNames: ['btn']
    classNameBindings: ['blockClass']
    classTypePrefix: 'btn'
    clickedParam: null
    block: null
    attributeBindings: ['disabled', 'dismiss:data-dismiss', '_type:type']
    _type: 'button'
    bubbles: true

    init: ->
        @_super()
        #If content is an object, then assign its properties to the button component
        if @get('content')? and Ember.typeOf(@get('content')) is 'instance'
            for key,val of @get('content')
                @set key, val
        else
            if not @get('title')?
                @set('title', @get('content'))
            @attributeBindings.pushObject attr for attr of @ when attr.match(/^data-[\w-]*$/)?

    blockClass: ( ->
        if @block then "#{@classTypePrefix}-block" else null
    ).property('block').cacheable()

    click: (evt) ->
        evt.stopPropagation() unless @get('bubbles')
        @sendAction('clicked', @get('clickedParam'))

    loadingChanged: (->
        loading = if @get('loading') isnt null then @get('loading') else "reset"
        Ember.$("##{@elementId}").button(loading)
    ).observes('loading')
)

Ember.Handlebars.helper 'bs-button', Bootstrap.BsButtonComponent
