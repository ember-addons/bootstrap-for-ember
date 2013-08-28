Showcase.ShowComponentsProgressbarController = Ember.Controller.extend(
    prog: 0
    incrementBy: 20

    increment: ->
        if @prog < 100
            @incrementProperty "prog", @incrementBy
        else
            @set "prog", @incrementBy
)