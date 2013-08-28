Showcase.Router.map(() ->
    @resource 'show_components', ->
        @route 'alert'
        @route 'label'
        @route 'badge'
        @route 'well'
        @route 'button'
        @route 'progressbar'
)