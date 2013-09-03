Bootstrap = window.Bootstrap
Bootstrap.Register = Ember.Mixin.create(
    init: ->
        @_super()
        @BsAlertComponent = Bootstrap.BsAlertComponent if Bootstrap.BsAlertComponent?
        @BsModalComponent = Bootstrap.BsModalComponent if Bootstrap.BsModalComponent?
        @BsWizardComponent = Bootstrap.BsWizardComponent if Bootstrap.BsWizardComponent?
        @BsLabelComponent = Bootstrap.BsLabelComponent if Bootstrap.BsLabelComponent?
        @BsBadgeComponent = Bootstrap.BsBadgeComponent if Bootstrap.BsBadgeComponent?
        @BsWellComponent = Bootstrap.BsWellComponent if Bootstrap.BsWellComponent?
        @BsPageHeaderComponent = Bootstrap.BsPageHeaderComponent if Bootstrap.BsPageHeaderComponent?
        @BsPanelComponent = Bootstrap.BsPanelComponent if Bootstrap.BsPanelComponent?
        @BsButtonComponent = Bootstrap.BsButtonComponent if Bootstrap.BsButtonComponent?
        @BsBtnToolbarComponent = Bootstrap.BsBtnToolbarComponent if Bootstrap.BsBtnToolbarComponent?
        @BsProgressComponent = Bootstrap.BsProgressComponent if Bootstrap.BsProgressComponent?
        @BsProgressbarComponent = Bootstrap.BsProgressbarComponent if Bootstrap.BsProgressbarComponent?
)