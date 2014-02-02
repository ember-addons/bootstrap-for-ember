###
Modal component.
###
Bootstrap.BsModalComponent = Ember.Component.extend(
    layoutName: 'components/bs-modal'
    classNames: ['modal']
    #classNameBindings: ['fade']
    attributeBindings: ['role', 'aria-labelledby', 'isAriaHidden:aria-hidden', "ariaLabelledBy:aria-labelledby"]
    isAriaHidden: (->
        "#{@get('isVisible')}"
    ).property('isVisible')
    modalBackdrop: '<div class="modal-backdrop fade in"></div>'
    role: 'dialog'

    #--Defaults--
    backdrop: true
    title: null
    isVisible: false
    manual: false

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
        @appendBackdrop() if @get("backdrop")

    becameHidden: ->
        @_backdrop.remove() if @_backdrop

    appendBackdrop: ->
        parentElement = @$().parent()
        @_backdrop = Em.$(@modalBackdrop).appendTo(parentElement)

    show: ->
        @set 'isVisible', true

    hide: ->
        @set 'isVisible', false

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
        if @get('manual') then @destroy() else @hide()

    #Invoked automatically by ember when the view is destroyed, giving us a chance to perform cleanups
    willDestroyElement: ->
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
    add: (name, modalView) ->
        @set name, modalView

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

    open: (name, title, view, footerButtons, controller) ->
        cl = controller.container.lookup 'component-lookup:main'
        modalComponent = cl.lookupFactory('bs-modal', controller.get('container')).create()

        modalComponent.setProperties(
            name: name
            title: title
            manual: true
            footerButtons: footerButtons
            targetObject: controller
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