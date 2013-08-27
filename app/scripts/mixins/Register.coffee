Bootstrap = window.Bootstrap
Bootstrap.Register = Ember.Mixin.create(
    init: ->
        @_super()
        @BsAlertComponent = Bootstrap.BsAlertComponent if Bootstrap.BsAlertComponent?
        @BsLabelComponent = Bootstrap.BsLabelComponent if Bootstrap.BsLabelComponent?
        @BsBadgeComponent = Bootstrap.BsBadgeComponent if Bootstrap.BsBadgeComponent?
        @BsWellComponent = Bootstrap.BsWellComponent if Bootstrap.BsWellComponent?
        @BsButtonComponent = Bootstrap.BsButtonComponent if Bootstrap.BsButtonComponent?
)