###
Breadcrumbs compponent.
###
Bootstrap.BsBreadcrumbsItem = Bootstrap.ItemView.extend(
    tagName: ['li']
    classNameBindings: ["isActive:active"]
    template: Ember.Handlebars.compile '{{#unless view.isActive}}{{#if view.content.model}}{{#link-to view.content.route model.id}}{{view.content.name}}{{/link-to}}{{else}}{{#link-to view.content.route}}{{view.content.name}}{{/link-to}}{{/if}}{{else}}{{view.content.name}}{{/unless}}'

    isActive: (->
        @get('content.active')
    ).property('content.active')
)

Bootstrap.BsBreadcrumbs = Bootstrap.ItemsView.extend(Bootstrap.WithRouter,
    tagName: ['ol']
    classNames: ['breadcrumb']
    currentPathObserver: (->
        #FIXME: without touching routing the observer in some latest versions of ember doesn't response
        @get('router');
        @send('updateCrumbsByRoute')
    ).observes('router.url').on('init')
    content: []
    itemViewClass: Bootstrap.BsBreadcrumbsItem
    nameDictionary: undefined
    dictionaryNamePrefix: 'breadcrumbs'

    actions:
        currentPathDidChange: ->
            @send 'updateCrumbsByRoute'

        updateCrumbsByRoute: ->
            @get('content').clear()

            routes = @get('container').lookup 'router:main'
            routes.get('router.currentHandlerInfos').forEach (route, i, arr) =>
                name = route.name
                return if name.indexOf('.index') isnt -1 || name is 'application'
                return if route.handler.breadcrumbs?.hidden

                routeName = route.handler.routeName
                if route.handler.breadcrumbs?.name
                    displayName = route.handler.breadcrumbs.name
                else if @get('nameDictionary')?["#{@dictionaryNamePrefix}.#{routeName}"]
                    displayName = @get('nameDictionary')["#{@dictionaryNamePrefix}.#{routeName}"]
                else
                    displayName = route.handler.routeName.split('.').pop()
                    displayName = displayName[0].toUpperCase() + displayName[1..-1].toLowerCase()

                crumb = Ember.Object.create
                    route: route.handler.routeName
                    name: displayName
                    model: null

                crumb.set('icon', 'fa fa-home home-icon') if @get('content').length is 0

                if route.isDynamic
                    crumb.setProperties
                        model: route.handler.context
                        name: route.handler.context.get('name')

                @get('content').pushObject crumb
            @get('content.lastObject').set 'active', true
)

Ember.Handlebars.helper 'bs-breadcrumbs', Bootstrap.BsBreadcrumbs