# helper to get the parent view and test its type
getParentView = (view) ->
    return unless view and (parentView = view.get 'parentView')
    # Ember objects respects the JS inheritence so instanceof can be used here
    ok = parentView instanceof Bootstrap.ItemsView
    Ember.assert "The parent view must be an instance of Bootstrap.ItemsView or any inherited class", ok
    if ok then parentView else undefined


# test if the given object is an Ember object or has a get method and use it to return a property
getProperty = (obj, prop, noGetReturns) ->
    return noGetReturns unless Ember.typeOf(obj) is 'instance' or Ember.canInvoke(obj, 'get')
    obj.get prop


###
Views that are rendered as an Item of the ItemsView should extends from this view.

When a click event is received the current item will be stored in the parent view 'selected' property,
An extra 'active' css class will be assigned to the Item (this) if this is a selected item.

Views that extends this view can be enhanced with:
ItemSelection: Makes the item selectable.
###
Bootstrap.ItemView = Ember.View.extend(
    isItem: true
    classNameBindings: ['disabled']

    ###
    A calculated property that defines the title of the item.
    ###
    title: (->
        return unless (itemsView = getParentView @)
        itemTitleKey = itemsView.get('itemTitleKey') || 'title'
        content = @get 'content'
        getProperty content, itemTitleKey, content
    ).property('content').cacheable()

    ###
    Determine whether the item is disabled or not
    ###
    disabled: (->
        return unless (itemsView = getParentView @)
        content = @get 'content'
        disabled = !!getProperty content, 'disabled', no
        itemsView.set('selected', null) if disabled and @get 'isActive'
        disabled
    ).property('content', 'content.disabled').cacheable()
)
