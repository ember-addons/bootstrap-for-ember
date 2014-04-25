###
A view that displays notification (messages).

Currently a single notification is displayed as an Alert on top of the screen, each notification in a time.
###
Bootstrap.NotificationsView = Ember.CollectionView.extend (
    classNames: ['notifications']
    attributeBindings: ['style']
    contentBinding: 'Bootstrap.NM.content'
    showTime: 2000
    fadeInTime: 500
    fadeOutTime: 3000
    showTimeTimeoutId: null

    ###
    itemViewClass: Bootstrap.BsAlertComponent.extend(
        messageBinding: 'content.message'
        typeBinding: 'content.type'
        fadeInTimeBinding: 'parentView.fadeInTime'
        isVisible: false

        didInsertElement: ->
            @$().fadeIn(@get('fadeInTime'))
    )
    ###

    itemViewClass: Ember.View.extend(
        classNames: ['alert', 'notification']
        template: Ember.Handlebars.compile '{{view.content.message}}'
        classNameBindings: ["alertType"]
        isVisible: false
        alertType: (->
            @get('content').get('classType')
        ).property('content')

        didInsertElement: ->
            @$().fadeIn(@get('fadeInTime'))
    )

    contentChanged: (->
        if @get('content').length > 0
            @resetShowTime()
    ).observes('content.length')

    resetShowTime: ->
        @$().css(display: 'block')
        @$().stop().animate opacity: "100" if @$().is(":animated")
        clearTimeout(@showTimeTimeoutId) if @showTimeTimeoutId?
        @showTimeTimeoutId = setTimeout(=>
            @fadeOut(@)
        , @showTime)

    fadeOut: (that)->
        that.$().fadeOut(that.fadeOutTime, () ->
            that.get('content').clear()
        )

    mouseEnter: () ->
        @$().stop().animate opacity: "100" if @$().is(":animated")

    mouseLeave: () ->
        @resetShowTime()
)

Ember.Handlebars.helper 'bs-notifications', Bootstrap.NotificationsView

Bootstrap.NM = Bootstrap.NotificationManager = Ember.Object.create(
    content: Ember.A()
    push: (message, type) ->
        type = type?= 'info'
        notif = Bootstrap.Notification.create(
            message: message
            type: type
        )
        @get('content').pushObject(notif)

)


###
This object represents a notification to be displayed.
Notification(s) are added into the NotificationQueue by the pushNotification function.
###
Bootstrap.Notification = Ember.Object.extend(
    classType: (->
        if @type? then "alert-#{@type}" else null
    ).property('type').cacheable()
)