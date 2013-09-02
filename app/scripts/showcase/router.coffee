Showcase.Router.map(() ->
    @resource 'show_components', ->
        @route 'alert'
        @route 'modal'
        @route 'label'
        @route 'badge'
        @route 'well'
        @route 'panel'
        @route 'page-header'
        @route 'button'
        @route 'buttonGroup'
        @route 'progressbar'
        @route 'pills'
        @route 'tabs'
        @route 'tabs-panes'
        @route 'tabs-with-routes'
        @route 'notifications'
        @resource('user', ->
            @route ('general')
            @route ('privacy')
            @route ('activities')
        )
)