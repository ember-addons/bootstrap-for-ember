###
A Mixin that provides the basic configuration for rendering a Bootstrap navigation such as tabs and pills
###
Bootstrap.Nav = Ember.Mixin.create(
    classNames: ['nav']
    classNameBindings: ['navTypeClass']
    tagName: 'ul'
    navType: null

    navTypeClass: ( ->
        if @navType? then "nav-#{@navType}" else null
    ).property('navType').cacheable()
)