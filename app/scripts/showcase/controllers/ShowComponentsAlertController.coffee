Showcase.ShowComponentsAlertController = Ember.Controller.extend(
    didAlertClosed: ->
        alert "From controller: The -closed- event was triggered."

    didAlertClose: ->
        alert "From controller: The -close- event was triggered."

    submit: ->
        alert "Action taken by controller!"

)