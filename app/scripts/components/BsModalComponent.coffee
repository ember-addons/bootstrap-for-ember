###
Modal component.
###
Bootstrap.BsModalComponent = Ember.Component.extend(Ember.Evented,
    layoutName: 'components/bs-modal'
    classNames: ['modal']
    classNameBindings: ['fade', 'isVis:in']
    attributeBindings: ['role', 'aria-labelledby', 'isAriaHidden:aria-hidden', "ariaLabelledBy:aria-labelledby"]
    isAriaHidden: (->
        "#{@get('isVisible')}"
    ).property('isVisible')
    modalBackdrop: '<div class="modal-backdrop fade in"></div>'
    role: 'dialog'
    footerViews: []

    #--Defaults--
    backdrop: true
    title: null
    isVisible: false
    manual: false
    isVis: false
    fullSizeButtons: false
    fade: true
    
    didInsertElement: ->
        @._super()
        @setupBinders()
        #Register modal in the modal manager
        name = @get('name')
        Ember.assert("Modal name is required for modal view #{@get('elementId')}", @get('name'))
        name?= @get('elementId')
        Bootstrap.ModalManager.add(name, @)

        if @manual
            @show()

    becameVisible: ->
        Em.$('body').addClass('modal-open')
        @appendBackdrop() if @get("backdrop")

    becameHidden: ->
        Em.$('body').removeClass('modal-open')
        @_backdrop.remove() if @_backdrop

    appendBackdrop: ->
        parentElement = @$().parent()
        @_backdrop = Em.$(@modalBackdrop).appendTo(parentElement)

    show: ->
        @set 'isVisible', true
        current = this
        setTimeout (->
            current.set 'isVis', true
            return
        ), 15
        return

    hide: ->
        @set 'isVis', false
        current = this
        @$().one 'webkitTransitionEnd', (e) ->
            current.set 'isVisible', false
            return
        false

    toggle: ->
        @toggleProperty 'isVisible'

    click: (event) ->
        target = event.target
        targetDismiss = target.getAttribute("data-dismiss")
        if targetDismiss is 'modal'
            @close()

    keyPressed: (event) ->
        #Handle ESC
        if event.keyCode is 27
            @close event

    close: (event) ->
        @set 'isVis', false
        current = this
        @$().one 'webkitTransitionEnd', (e) ->
            if current.get('manual') then current.destroy() else current.hide()
            return
         @trigger 'closed'
        

    #Invoked automatically by ember when the view is destroyed, giving us a chance to perform cleanups
    willDestroyElement: ->
        Em.$('body').removeClass('modal-open')
        @removeHandlers()
        name = @get('name')
        name?= @get('elementId')
        Bootstrap.ModalManager.remove(name, @)
        @_backdrop.remove() if @_backdrop

    removeHandlers: ->
        #Remove key press
        jQuery(window.document).unbind "keyup", @_keyUpHandler

    setupBinders: ->
        #Key press
        handler = (event) =>
            @keyPressed event
        jQuery(window.document).bind "keyup", handler
        @_keyUpHandler = handler
)

###
Bootstrap.BsModalComponent = Bootstrap.BsModalComponent.reopenClass(
    build: (options) ->
        options = {}  unless options
        options.manual = true
        modalPane = @create(options)
        modalPane.append()
)
###

Bootstrap.ModalManager = Ember.Object.create(
    add: (name, modalInstance) ->
        @set name, modalInstance

    register: (name, modalInstance) ->
        @add(name, modalInstance);
        modalInstance.appendTo(modalInstance.get('targetObject').namespace.rootElement)

    remove: (name) ->
        @set name, null

    close: (name) ->
        @get(name).close()

    hide: (name) ->
        @get(name).hide()

    show: (name) ->
        @get(name).show()

    toggle: (name) ->
        @get(name).toggle()

    confirm: (controller, title, message, confirmButtonTitle = "Confirm", cancelButtonTitle = "Cancel", targetObj = controller, fade = true, fullSizeButtons = false) ->
        body = Ember.View.extend(
            template: Ember.Handlebars.compile(message || "Are you sure you would like to perform this action?")
        )
        buttons = [
            Ember.Object.create({title: confirmButtonTitle, clicked:"modalConfirmed", dismiss: 'modal'})
            Ember.Object.create({title: cancelButtonTitle, clicked:"modalCanceled", dismiss: 'modal'})
        ]
        @open('confirm-modal', title || 'Confirmation required!', body, buttons, controller, fade, fullSizeButtons, targetObj)
		
	okModal: (controller, title, message, okButtonTitle = "OK", okButtonEvent = "okModal", targetObj = controller, fade = true, fullSizeButtons = false) ->
        body = Ember.View.extend(
            template: Ember.Handlebars.compile(message || "Are you sure you would like to perform this action?")
        )
        buttons = [
            Ember.Object.create({title: okButtonTitle, clicked:okButtonEvent, dismiss: 'modal'})
        ]
        @open('ok-modal', title || 'Confirmation required!', body, buttons, controller, fade, fullSizeButtons, targetObj)

    openModal: (modalView, options = {}) ->
        rootElement = options.rootElement or '.ember-application'
        instance = modalView.create options
        instance.appendTo rootElement

    open: (name, title, view, footerButtons, controller, fade , fullSizeButtons = false, targetObj = controller) ->
        cl = controller.container.lookup 'component-lookup:main'
        modalComponent = cl.lookupFactory('bs-modal', controller.get('container')).create()

        modalComponent.setProperties(
            name: name
            title: title
            manual: true
            footerButtons: footerButtons
            targetObject: targetObj
            fade: fade
            fullSizeButtons: fullSizeButtons
        )

        if Ember.typeOf(view) is 'string'
            template = controller.container.lookup("template:#{view}")
            Ember.assert("Template #{view} was specified for Modal but template could not be found.", template)
            if template
                modalComponent.setProperties(
                    body: Ember.View.extend(
                        template: template,
                        controller: controller
                    )
                )
        else if Ember.typeOf(view) is 'class'
            modalComponent.setProperties(
                body: view,
                controller: controller
            )

        modalComponent.appendTo(controller.namespace.rootElement)
)


Ember.Application.initializer
    name: 'bs-modal'
    initialize: (container, application) ->
        container.register 'component:bs-modal', Bootstrap.BsModalComponent