###
A Growl-like notifications component.
Originally written by Aaron Haurwitz (http://aaron.haurwitz.com/), licensed under MIT.
###
Bootstrap.GrowlNotifications = Ember.CollectionView.extend (
    ###
    @property {String[]} The array of concrete class names to put on this view's element
    ###
    classNames: ['notifications']
    ###
    Binding to the GrowlNotificationManager's notifications array
    Each of the array element will be rendered as a notification view (see ItemViewClass)
    ###
    contentBinding: Ember.Binding.oneWay 'Bootstrap.GNM.notifications'
    attributeBindings: ['style']
    showTime: 10000

    ###
    @property {View} Notification view class
    Determines what view class to render for each item in the content array.
    ###
    itemViewClass: Ember.View.extend(
        classNames: ['notification']
        template: Ember.Handlebars.compile [
            '<span class="glyphicon {{unbound view.iconType}} icon"></span>'
            '<a class="close-notification" {{action "close" target="view"}}>'
                '<span style="font-size: 15px;" class="glyphicon glyphicon-remove"></span>'
            '</a>'
            '<strong>'
                '{{view.content.title}}'
            '</strong>'
            '<p>'
                '{{view.content.sub}}'
            '</p>'
        ].join("\n")
        classNameBindings: [
            ":notification"
            "content.closed"
            "isOpaque"
        ]
        attributeBindings: ['style']
        ###
        @property {Number} Will be set by `didInsertElement`, used for clearing the auto-hide timeout.
        ###
        timeoutId: null
        ###
        @property {Boolean} should the view be opaque now?
        Used for fancy fading purposes.
        ###
        isOpaue: false

        ###
        Lifecycle hook - called when view is created.
        ###
        init: ->
            @._super()
            fn = (->
                @notifyPropertyChange "style"
            ).bind(@)
            @set "_recomputeStyle", fn
            $(window).bind "resize", fn

        ###
        View lifecycle hook - called when the view enters the DOM.
        ###
        didInsertElement: ->
            #@$().fadeIn(@get('fadeInTime'))
            # Be prepared to auto-hide the notification
            @set "timeoutId", setTimeout((->
                #@send "close"
                @close()
            ).bind(this), @get("parentView.showTime"))

            # Fade in the view.
            Ember.run.later this, (->
              @set "isOpaque", true
            ), 1

        ###
        Lifecycle hook - called right before view is destroyed
        ###
        willDestroyElement: ->
            $(window).unbind('resize', @get('_recomputeStyle'))

        close: ->
            @set('isOpaque', false)
            setTimeout (->
                @set "content.closed", true
                clearTimeout @get("timeoutId")
            ).bind(@), 300

        style: (->
            notifications = @get('parentView.content').rejectProperty('closed', true)
            index = notifications.indexOf(@get('content'))
            viewportHeight = $(window).height()
            unitHeight = 80
            unitWidth = 320
            unitsPerColumn = Math.floor(viewportHeight / unitHeight)
            column = Math.floor(index / unitsPerColumn)
            row = index % unitsPerColumn

            return '' if index is -1
            topPx = row * unitHeight
            rightPx = column * unitWidth

            'top: ' + topPx + 'px; right: ' + rightPx + 'px;'
        ).property('parentView.content.@each.closed')


        ###
        This is simply computed property for mapping a meaningful type name to a FontAwesome CSS class.
        ###
        iconType: (->
            type = this.get('content.type')
            hash =
                'info': 'glyphicon-bullhorn'
                'success': 'glyphicon-ok'
                'warning': 'glyphicon-exclamation-sign'
                'danger': 'glyphicon-remove'
            hash[type] || ''
        ).property('content.type')
    )
)

Ember.Handlebars.helper 'bs-growl-notifications', Bootstrap.GrowlNotifications

###
A manager that is responsible for getting told about new notifications and storing them within an array.
###
Bootstrap.GNM = Bootstrap.GrowlNotificationManager = Ember.Object.create(
    ###
    @property {Array} A global array for storing notification objects.
    ###
    notifications: Ember.A()

    ###
    @observer Not technically necessary, but cleans up the notifications array when all have been closed
    ###
    notificationClosed: (->
        notifications = @get('notifications')
        #Don't do anything if there are no notifications.
        return if not notifications.length

        #If all the notifications have been closed, wipe our list clean so cruft doesn't build up
        @set('notifications', Em.A()) if @get('notifications').everyBy('closed')
    ).observes('notifications.@each.closed')

    ###
    An exposed method for pushing new notification.
    @param title {String} leading text
    @param sub {String} supporting text
    @param type {String} classification; used for which icon to show
    ###
    push: (title, sub, type) ->
        type = type?= 'info'
        notif = Bootstrap.Notification.create(
            title: title
            sub: sub
            type: type
            closed: false
        )
        @get('notifications').pushObject(notif)
)


###
An object that represents a notification to be displayed.
###
Bootstrap.GrowlNotification = Ember.Object.extend(
)