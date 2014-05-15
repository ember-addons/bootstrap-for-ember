/*
A view that displays notification (messages).

Currently a single notification is displayed as an Alert on top of the screen, each notification in a time.
*/


(function() {
  Bootstrap.NotificationsView = Ember.CollectionView.extend({
    classNames: ['notifications'],
    attributeBindings: ['style'],
    contentBinding: 'Bootstrap.NM.content',
    showTime: 2000,
    fadeInTime: 500,
    fadeOutTime: 3000,
    showTimeTimeoutId: null,
    /*
    itemViewClass: Bootstrap.BsAlertComponent.extend(
        messageBinding: 'content.message'
        typeBinding: 'content.type'
        fadeInTimeBinding: 'parentView.fadeInTime'
        isVisible: false
    
        didInsertElement: ->
            @$().fadeIn(@get('fadeInTime'))
    )
    */

    itemViewClass: Ember.View.extend({
      classNames: ['alert', 'notification'],
      template: Ember.Handlebars.compile('{{view.content.message}}'),
      classNameBindings: ["alertType"],
      isVisible: false,
      alertType: (function() {
        return this.get('content').get('classType');
      }).property('content'),
      didInsertElement: function() {
        return this.$().fadeIn(this.get('fadeInTime'));
      }
    }),
    contentChanged: (function() {
      if (this.get('content').length > 0) {
        return this.resetShowTime();
      }
    }).observes('content.length'),
    resetShowTime: function() {
      var _this = this;
      this.$().css({
        display: 'block'
      });
      if (this.$().is(":animated")) {
        this.$().stop().animate({
          opacity: "100"
        });
      }
      if (this.showTimeTimeoutId != null) {
        clearTimeout(this.showTimeTimeoutId);
      }
      return this.showTimeTimeoutId = setTimeout(function() {
        return _this.fadeOut(_this);
      }, this.showTime);
    },
    fadeOut: function(that) {
      return that.$().fadeOut(that.fadeOutTime, function() {
        return that.get('content').clear();
      });
    },
    mouseEnter: function() {
      if (this.$().is(":animated")) {
        return this.$().stop().animate({
          opacity: "100"
        });
      }
    },
    mouseLeave: function() {
      return this.resetShowTime();
    }
  });

  Ember.Handlebars.helper('bs-notifications', Bootstrap.NotificationsView);

  Bootstrap.NM = Bootstrap.NotificationManager = Ember.Object.create({
    content: Ember.A(),
    push: function(message, type) {
      var notif;
      type = type != null ? type : type = 'info';
      notif = Bootstrap.Notification.create({
        message: message,
        type: type
      });
      return this.get('content').pushObject(notif);
    }
  });

  /*
  This object represents a notification to be displayed.
  Notification(s) are added into the NotificationQueue by the pushNotification function.
  */


  Bootstrap.Notification = Ember.Object.extend({
    classType: (function() {
      if (this.type != null) {
        return "alert-" + this.type;
      } else {
        return null;
      }
    }).property('type').cacheable()
  });

}).call(this);
