###
Parent component of a progressbar component
###
Bootstrap.BsProgressComponent = Ember.Component.extend(
    layoutName: 'components/bs-progress'
    classNames: ['progress']
    classNameBindings: ['animated:active', 'stripped:progress-striped']

    #If specified, a default progressbar is rendered, otherwise the user requires to supply a bs-progressbar sub component
    progress: null
    stripped:false
    animated:false

    default: (->
        @progress
    ).property('progress')
)

Ember.Handlebars.helper 'bs-progress', Bootstrap.BsProgressComponent