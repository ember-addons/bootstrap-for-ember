###
A parent view of views that supports multiple items rendering such as Navigations (Tabs, Pills)

Views that inherits from this view can be enhanced with:
- ItemsSelection: Enhances with selection capability.
###
Bootstrap.ItemsView = Ember.CollectionView.extend(
    didInsertElement: () ->
        #activate default tab if defined in item's metadata
        if @get('default')
            defaultTab = @get('default')
            for view in @._childViews
                @set 'selected', view.get('content') if view.get('content')?.get('title') is defaultTab
            Ember.assert("Could not activate default tab #{defaultTab} as it doesnt exist", defaultTab)
)