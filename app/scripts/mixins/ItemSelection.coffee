###
A Mixin to enhance items enhanced with the 'IsItem' Mixin with selection capability.

When a click event is received the current item will be stored in the parent view 'selected' property,
An extra 'active' css class will be assigned to the Item (this) if this is a selected item.
###
Bootstrap.ItemSelection = Ember.Mixin.create(Bootstrap.ItemValue, Bootstrap.WithRouter,
    classNameBindings: ["isActive:active"]

    init: ->
        @_super()
        @didRouteChange()

    didRouteChange: (->
        linkTo = @get('content.linkTo')
        return unless linkTo?
        itemsView = @get('parentView')
        return unless itemsView?
        if @get('router')?.isActive(linkTo)
            itemsView.set('selected', @get('value'))
    ).observes('router.url')

    ###
    Determine whether the current item is selected,
    if true the 'active' css class will be associated with the this DOM's element.

    This is a calculated property and will be retriggered if the 'value' property of the item has changed or the 'selected' property
    in the parent ItemsView.
    ###
    isActive: (->
        #TODO: Ensure parentView is inherited from ItemsView
        itemsView = @get('parentView')
        if not itemsView?
            return false
        selected = itemsView.get 'selected'
        value = @get 'value'

        if not value?
            return false

        selected is value
    ).property('value', 'parentView.selected', 'content.linkTo').cacheable()

    ###
    Handle selection by click event.

    The identifier of the selection is based on the 'content' property of this item.
    ###
    click: (event) ->
        #event.stopPropagation()
        event.preventDefault()

        #TODO: Ensure parentView is inherited from ItemsView
        itemsView = @get('parentView')
        if not itemsView?
            return

        content = @get('content')
        #TODO: Ensure its an Ember object
        if typeof(content) is 'object'
            return if content.get('disabled')

        # items with linkTo will be dispatched in didRouteChange
        return if @get('content.linkTo')?

        #Currently multi selection is not supported
        itemsView.set('selected', @get('value'))
)
