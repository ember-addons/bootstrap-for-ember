Bootstrap.BsWellComponent = Ember.Component.extend(
    classNameBindings: ['small:well-sm', 'large:well-lg']
    classNames: ['well']

    click: ->
        @sendAction('clicked')
)