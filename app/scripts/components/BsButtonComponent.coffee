Bootstrap.BsButtonComponent = Ember.Component.extend(Bootstrap.TypeSupport, Bootstrap.SizeSupport,
    tagName: 'button'
    classNames: ['btn']
    classNameBindings: ['blockClass']
    classTypePrefix: 'btn'
    block: null
    attributeBindings: ['disabled']

    init: ->
      @_super()
      @attributeBindings.pushObject attr for attr of @ when attr.match(/^data-\w*-text$/)?

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
