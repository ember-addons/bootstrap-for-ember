Showcase.ShowComponentsModalController = Ember.Controller.extend(
    #Footer buttons meta data
    myModalButtons: [
        {title: 'Submit', clicked:"submit"}
        {title: 'Cancel', clicked:"cancel", dismiss: 'modal'}
    ]

    manualButtons: [
        {title: 'Submit', clicked:"submitManual"}
        {title: 'Cancel', dismiss: 'modal'}
    ]


    actions:
        #Submit the modal
        submit: ->
            #Send a notification upon success submission
            Bootstrap.NM.push('Successfully submitted modal', 'success')
            #Hide the modal programatically
            Bootstrap.ModalManager.hide('myModal')

        #Cancel the modal, we don't need to hide the model manually because we set {..., dismiss: 'modal'} on the button meta data
        cancel: ->
            Bootstrap.NM.push('Modal was cancelled', 'info')

        #Show the modal
        show: ->
            Bootstrap.ModalManager.show('myModal')

        #Close (destroys) a programatically created modal
        submitManual: ->
            Bootstrap.NM.push('Modal destroyed!', 'success')
            Bootstrap.ModalManager.close('manualModal')

        createModalProgramatically: ->
            Bootstrap.BsModalComponent.build(
                name: 'manualModal'
                title: 'Invite Member'
                #The modal's body content will be set to the templateName's content
                templateName: 'demo-template'
                #NOTE: this is important if you want the context of the modal to be the current component, it's possible to set other controllers too.
                targetObject: @
                footerButtons: @manualButtons
            )
)