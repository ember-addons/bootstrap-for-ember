Bootstrap = window.Bootstrap
get = Ember.get

Bootstrap.WithRouter = Ember.Mixin.create(
    router: Ember.computed( ->
        get(this, "controller").container.lookup "router:main"
    )
)