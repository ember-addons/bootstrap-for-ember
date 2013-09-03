Bootstrap.BsWizardStep = Bootstrap.ItemView.extend(Bootstrap.ItemSelection,Bootstrap.NavItem,
    classNames: ['wizard-step']
    classNameBindings: ['completed']
    completed: false
    template: Ember.Handlebars.compile([
        '{{view view.stepAsLink}}'
    ].join("\n")
    )

    stepAsLink: Ember.View.extend (
        tagName: 'a'
        template: Ember.Handlebars.compile('{{view.parentView.title}}')
        attributeBindings: ['href']
        href: "#"
    )
)

Bootstrap.BsWizardSteps = Bootstrap.ItemsView.extend(Bootstrap.Nav,
    navType: 'pills'
    classNames: ['wizard-steps']
    itemViewClass: Bootstrap.BsWizardStep

    currentItemIdx: (->
        selected = @get('selected')
        i=0
        for view in @._childViews
            if view.get('content') is selected
                selectedItem = view
                break
            i++

        if selectedItem then i else null
    ).property('selected')
)

Bootstrap.BsWizardStepPane = Bootstrap.ItemPaneView.extend(
)

Bootstrap.BsWizardStepsPanes = Bootstrap.ItemsPanesView.extend(
    classNames: ['wizard-panes']
    itemViewClass: Bootstrap.BsWizardStepPane
)

Bootstrap.BsWizardComponent = Ember.ContainerView.extend(
    classNames: ['wizard']
    childViews: ['steps', 'panes', 'controls']
    prevAllowed: true

    items: (->
        @._childViews?[0]
    ).property('content')

    panes: (->
        @._childViews[1]
    ).property('content')

    steps: Bootstrap.BsWizardSteps.extend(
        contentBinding: 'parentView.content'
        selectedBinding: 'parentView.selected'
    )

    panes: Bootstrap.BsWizardStepsPanes.extend(
        contentBinding: 'parentView.content'
    )

    controls: Ember.ContainerView.extend (
        childViews: ['prev', 'next', 'finish']

        prev: Bootstrap.BsButtonComponent.extend(
            title: 'Prev'
            size: 'xs'
            elementId: 'prev'
            isVisible: (->
                @get('parentView').get('parentView').get('hasPrev')
            ).property('parentView.parentView.items.selected')
        )
        next: Bootstrap.BsButtonComponent.extend(
            title: 'Next'
            size: 'xs'
            elementId: 'next'
            isVisible: (->
                @get('parentView').get('parentView').get('hasNext')
            ).property('parentView.parentView.items.selected')
        )
        finish: Bootstrap.BsButtonComponent.extend(
            title: 'Finish'
            size: 'xs'
            elementId: 'finish'
            isVisible: (->
                @get('parentView').get('parentView').get('isLast')
            ).property('parentView.parentView.items.selected')
        )
    )

    currentStepIdx: (->
        @get('items').get('currentItemIdx')
    #TODO: Although the selectedBinding: 'parentView.selected', this doesnt work properly and is only calculated in the next change for some unknown reason.
    #).property('selected')
    ).property('items.selected')

    willInsertElement: ->
        @get('panes').set('items-id',@get('items').get('elementId'))
        @get('items').set('default', @.get('items')._childViews[0].get('content').get('title'))

    click: (event) ->
        b = event.target.getAttribute("id")
        @prev() if b is 'prev'
        @next() if b is 'next'
        @close() if b is 'finish'

    next: () ->
        if @get('hasNext')
            @stepCompleted(@get('currentStepIdx'))
            currIdx = @get('currentStepIdx')+1
            #@set 'currentItemIdx', currIdx
            @move(currIdx)

    prev: () ->
       if @get('hasPrev')
            currIdx = @get('currentStepIdx')-1
            @stepCompleted(currIdx, false)
            #@set 'currentItemIdx', currIdx
            @move(currIdx)

    move: (idx) ->
        @._childViews[0]?.set 'selected', @._childViews[0]._childViews[idx]?.get('content')

    hasNext: (->
        @get('items')._childViews.length > @get('currentStepIdx')+1
    ).property('currentStepIdx')

    hasPrev: (->
        @get('currentStepIdx') > 0
    ).property('currentStepIdx')

    isLast: (->
        @get('items')._childViews.length is @get('currentStepIdx')+1
    ).property('currentStepIdx')

    close: ( ->
        @destroy()
    )

    stepCompleted: (idx, compl=true) ->
        @._childViews[0]._childViews[idx].set('completed', compl)
)

Ember.Handlebars.helper('bs-wizard', Bootstrap.BsWizardComponent)