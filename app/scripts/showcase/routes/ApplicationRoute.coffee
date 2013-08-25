Showcase.ApplicationRoute = Ember.Route.extend(
    model: () ->
        [
            #Alert
            Ember.Object.create({title: "Alert", route: "show_components.alert"})
            Ember.Object.create({title: "Label", route: "show_components.label"})
        ]
)