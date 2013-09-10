Showcase.ShowComponentsWizardController = Ember.Controller.extend(
    init: () ->
        @._super()

        @set('steps', Ember.A([
            Ember.Object.create({ title: 'Foo', template: 'tabs/foo-tabpane'})
            Ember.Object.create({ title: 'Bar', template: 'tabs/bar-tabpane'})
            Ember.Object.create({ title: 'Baz', template: 'tabs/baz-tabpane'})
        ]))

        @set('stepsNoPrev', Ember.A([
            Ember.Object.create({ title: 'Step1', template: 'tabs/foo-tabpane', disabled: true})
            Ember.Object.create({ title: 'Step2', template: 'tabs/bar-tabpane', disabled: true})
            Ember.Object.create({ title: 'Step3', template: 'tabs/baz-tabpane', disabled: true})
        ]))


    actions:
        createWizard: () ->
            body = Bootstrap.BsWizardComponent.extend(
                content: [
                    Ember.Object.create({ title: 'Step1', template: 'wizard/step1', disabled: true})
                    Ember.Object.create({ title: 'Step2', template: 'wizard/step2', disabled: true})
                    Ember.Object.create({ title: 'Step3', template: 'wizard/step3', disabled: true})
                ]
                #Important: set targetObject to 'this' so the wizard can communicate with our controller
                targetObject: @
                onNext: "onNext"
                onPrev: "onPrev"
                onFinish: 'onFinish'
            )

            Bootstrap.ModalManager.open('manualModal', 'Wizard Title...', body, null, @)

        onNext: ->
            console.log 'NEXT'

        onPrev: ->
            console.log 'PREV'

        onFinish: =>
            #Close the modal when the wizard has finished its job.
            Bootstrap.ModalManager.close('manualModal')
            Bootstrap.NM.push('Wizard completed!')
)
