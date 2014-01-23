Bootstrap.ItemPaneView = Ember.View.extend(
    template: Ember.Handlebars.compile [
        '{{#if view.content.template}}'
        '{{bsItemPanePartial view.content.template}}'
        '{{/if}}'
    ].join("\n")

    corrItem: (->
        if @get('parentView').get('corrItemsView')?
            for view in @get('parentView').get('corrItemsView')._childViews
                return view if view.content is @get('content')
    ).property('parentView.corrItemsView')

    isVisible: (->
        @get('corrItem')?.get('isActive')
    ).property('corrItem.isActive')

    controller: (->
        controller = @get('parentView.controller')
        if @get('content.controller')
            itemController = @get('container').lookup("controller:#{@get('content.controller')}")
            controller = itemController if itemController
        return controller
    ).property('content')
)

#TODO: Is there a simple way to do this without passing through a helper?
Ember.Handlebars.helper("bsItemPanePartial", (templateName, options) ->
    view = options.data.view
    template = view.templateForName(templateName)
    Ember.assert("Unable to find template with name '#{templateName}'", template)
    template(@, { data: options.data })
)