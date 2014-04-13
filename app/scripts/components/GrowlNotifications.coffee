###
A Growl-like notifications component.
Originally written by Aaron Haurwitz (http://aaron.haurwitz.com/), licensed under MIT.
###
Bootstrap.GrowlNotifications = Ember.CollectionView.extend (
    ###
    @property {String[]} The array of concrete class names to put on this view's element
    ###
    classNames: ['growl-notifications']
    ###
    Binding to the GrowlNotificationManager's notifications array
    Each of the array element will be rendered as a notification view (see ItemViewClass)
    ###
    contentBinding: 'Bootstrap.GNM.notifications'
    attributeBindings: ['style']
    showTime: 10000

    ###
    @property {View} Notification view class
    Determines what view class to render for each item in the content array.
    ###
    itemViewClass: Ember.View.extend(
        classNames: ['growl-notification']
        template: Ember.Handlebars.compile '''
            <span class="icon"><i class="fa {{unbound view.iconType}}"></i></span>
            <a class="close-notification" {{action "close" target="view"}}>
                <span style="font-size: 15px;"><i class="fa fa-times"></i></span>
            </a>
            <strong>
                {{view.content.title}}
            </strong>
            <p>
                {{view.content.sub}}
            </p>
        '''
        classNameBindings: [
            ":growl-notification"
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
        isOpaque: false

        ###
        Lifecycle hook - called when view is created.
        ###
        init: ->
            @._super()
            fn = (=>
                @notifyPropertyChange "style"
            )
            @set "_recomputeStyle", fn
            $(window).bind "resize", fn

        ###
        View lifecycle hook - called when the view enters the DOM.
        ###
        didInsertElement: ->
            #@$().fadeIn(@get('fadeInTime'))
            # Be prepared to auto-hide the notification
            @set "timeoutId", setTimeout((=>
                #@send "close"
                @send("close")
            ), @get("parentView.showTime"))

            # Fade in the view.
            Ember.run.later this, (->
              @set "isOpaque", true
            ), 1

        ###
        Lifecycle hook - called right before view is destroyed
        ###
        willDestroyElement: ->
            $(window).unbind('resize', @get('_recomputeStyle'))


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
                'info': 'fa-bullhorn'
                'success': 'fa-check'
                'warning': 'fa-exclamation'
                'danger': 'fa-times'
            hash[type] || ''
        ).property('content.type')

        actions:
            close: ->
                @set('isOpaque', false)
                setTimeout (=>
                    @get('parentView.content').removeObject(@get('content'))
                    clearTimeout @get("timeoutId")

                ), 300
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