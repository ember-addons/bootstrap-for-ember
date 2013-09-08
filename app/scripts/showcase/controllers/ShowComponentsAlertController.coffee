Showcase.ShowComponentsAlertController = Ember.Controller.extend(
    actions:
        submit: ->
            alert "Action taken by controller!"

        didAlertClosed: ->
            alert "From controller: The -closed- event was triggered."

        didAlertClose: ->
            alert "From controller: The -close- event was triggered."
)