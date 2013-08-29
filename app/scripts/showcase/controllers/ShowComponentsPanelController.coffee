Showcase.ShowComponentsPanelController = Ember.Controller.extend(
    panelClicked: ->
        alert "Hello from controller: A click in a panel!"

    panelClosed: ->
        alert "Hello from controller: The panel was closed!"
)