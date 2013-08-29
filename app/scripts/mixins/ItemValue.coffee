###
A mixin for Items that have a value property
###
Bootstrap.ItemValue = Ember.Mixin.create(
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
)