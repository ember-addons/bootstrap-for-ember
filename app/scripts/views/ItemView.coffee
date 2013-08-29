###
Views that are rendered as an Item of the ItemsView should extends from this view.

When a click event is received the current item will be stored in the parent view 'selected' property,
An extra 'active' css class will be assigned to the Item (this) if this is a selected item.

Views that extends this view can be enhanced with:
ItemSelection: Makes the item selectable.
###
Bootstrap.ItemView = Ember.View.extend (
    isItem: true
    classNameBindings: ['disabled']

    ###
    The value of the item, currently Items content supports only an array of strings, so value is the actual 'content' property
    of the item.
    ###
    value: (->
        #TODO: Ensure parentView is inherited from ItemsView
        itemsView = @get('parentView')
        if not itemsView?
            return

        value = @get('content')
        value
    ).property('content').cacheable()

    ###
    A calculated property that defines the title of the item.
    ###
    title: (->
        #TODO: Ensure parentView is inherited from ItemsView
        itemsView = @get('parentView')
        if not itemsView?
            return

        itemTitleKey = itemsView.get('itemTitleKey') || 'title'
        content = @get('content')
        #TODO: content is 'object' is not sufficient, it is required to also check that this is an Ember object or has a get method
        if typeof(content) is 'object' then content.get(itemTitleKey) else content
    ).property('content').cacheable()

    ###
    Determine whether the item is disabled or not
    ###
    disabled: (->
        #TODO: Ensure parentView is inherited from ItemsView
        itemsView = @get('parentView')
        if not itemsView?
            return

        content = @get('content')
        #TODO: content is 'object' is not sufficient, it is required to also check that this is an Ember object or has a get method
        if typeof(content) is 'object'
            if content.get('disabled')
                #remove selection if item is selected
                if @get('isActive')
                    itemsView.set('selected', null)
                return content.get('disabled')
            else
                false

        false
    ).property('content', 'content.disabled').cacheable()
)