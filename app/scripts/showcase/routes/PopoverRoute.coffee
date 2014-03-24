Showcase.ShowComponentsPopoverRoute = Ember.Route.extend
    renderTemplate: () ->
        #Render default outlet
        @render()
        #render extra outlets
        controller = @controllerFor 'ShowComponentsTooltipBox'
        @render 'bs-tooltip-box',
            outlet: "bs-tooltip-box"
            controller: controller
            into: "application"