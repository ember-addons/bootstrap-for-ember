Showcase.Router.map(() ->
    @resource 'show_components', ->
        @route 'alert'
        @route 'breadcrumbs'
        @route 'modal'
        @route 'label'
        @route 'badge'
        @route 'well'
        @route 'list-group'
        @route 'panel'
        @route 'page-header'
        @route 'button'
        @route 'buttonGroup'
        @route 'progressbar'
        @route 'pills'
        @route 'tabs'
        @route 'tabs-panes'
        @route 'wizard'
        @route 'items_action_bar'
        @route 'tabs-with-routes'
        @route 'notifications'
        @route 'growl-notif'
        @route 'popover'
        @resource('user', ->
            @route ('general')
            @route ('privacy')
            @route ('activities')
        )
)