Showcase.ShowComponentsButtonController = Ember.Controller.extend(
    isButtonDisabled: false
    loadingState: null
    loadingState1: null

    actions:
        disableButton: ->
            @set 'isButtonDisabled', true

        startLoading: ->
            @set 'loadingState', 'loading'
            Ember.run.later(() =>
                @set 'loadingState', null
            , 2000)

        startLoading1: ->
            @set 'loadingState1', 'loading'
            Ember.run.later(() =>
                @set 'loadingState1', 'completed'
            , 2000)

        buttonWithParam: (expectedMyself) ->
            alert "Passed controller as a param: #{expectedMyself}"
)