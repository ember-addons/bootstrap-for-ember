Showcase.ApplicationRoute = Ember.Route.extend(
    model: () ->
        [
            Ember.Object.create({title: "Alert", route: "show_components.alert"})
            Ember.Object.create({title: "Label", route: "show_components.label"})
            Ember.Object.create({title: "Badge", route: "show_components.badge"})
            Ember.Object.create({title: "Well", route: "show_components.well"})
            Ember.Object.create({title: "Button", route: "show_components.button"})
        ]
)