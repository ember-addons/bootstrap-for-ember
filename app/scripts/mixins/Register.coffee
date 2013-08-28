Bootstrap = window.Bootstrap
Bootstrap.Register = Ember.Mixin.create(
    init: ->
        @_super()
        @BsAlertComponent = Bootstrap.BsAlertComponent if Bootstrap.BsAlertComponent?
        @BsLabelComponent = Bootstrap.BsLabelComponent if Bootstrap.BsLabelComponent?
        @BsBadgeComponent = Bootstrap.BsBadgeComponent if Bootstrap.BsBadgeComponent?
        @BsWellComponent = Bootstrap.BsWellComponent if Bootstrap.BsWellComponent?
        @BsPageHeaderComponent = Bootstrap.BsPageHeaderComponent if Bootstrap.BsPageHeaderComponent?
        @BsButtonComponent = Bootstrap.BsButtonComponent if Bootstrap.BsButtonComponent?
        @BsProgressComponent = Bootstrap.BsProgressComponent if Bootstrap.BsProgressComponent?
        @BsProgressbarComponent = Bootstrap.BsProgressbarComponent if Bootstrap.BsProgressbarComponent?
)