/*
A Growl-like notifications component.
Originally written by Aaron Haurwitz (http://aaron.haurwitz.com/), licensed under MIT.
*/


(function() {
  Bootstrap.GrowlNotifications = Ember.CollectionView.extend({
    /*
    @property {String[]} The array of concrete class names to put on this view's element
    */

    classNames: ['growl-notifications'],
    /*
    Binding to the GrowlNotificationManager's notifications array
    Each of the array element will be rendered as a notification view (see ItemViewClass)
    */

    contentBinding: 'Bootstrap.GNM.notifications',
    attributeBindings: ['style'],
    showTime: 10000,
    /*
    @property {View} Notification view class
    Determines what view class to render for each item in the content array.
    */

    itemViewClass: Ember.View.extend({
      classNames: ['growl-notification'],
      template: Ember.Handlebars.compile('<span class="icon"><i class="fa {{unbound view.iconType}}"></i></span>\n<a class="close-notification" {{action "close" target="view"}}>\n    <span style="font-size: 15px;"><i class="fa fa-times"></i></span>\n</a>\n<strong>\n    {{view.content.title}}\n</strong>\n<p>\n    {{view.content.sub}}\n</p>'),
      classNameBindings: [":growl-notification", "content.closed", "isOpaque"],
      attributeBindings: ['style'],
      /*
      @property {Number} Will be set by `didInsertElement`, used for clearing the auto-hide timeout.
      */

      timeoutId: null,
      /*
      @property {Boolean} should the view be opaque now?
      Used for fancy fading purposes.
      */

      isOpaque: false,
      /*
      Lifecycle hook - called when view is created.
      */

      init: function() {
        var fn;
        this._super();
        fn = (function() {
          return this.notifyPropertyChange("style");
        }).bind(this);
        this.set("_recomputeStyle", fn);
        return $(window).bind("resize", fn);
      },
      /*
      View lifecycle hook - called when the view enters the DOM.
      */

      didInsertElement: function() {
        this.set("timeoutId", setTimeout((function() {
          return this.send("close");
        }).bind(this), this.get("parentView.showTime")));
        return Ember.run.later(this, (function() {
          return this.set("isOpaque", true);
        }), 1);
      },
      /*
      Lifecycle hook - called right before view is destroyed
      */

      willDestroyElement: function() {
        return $(window).unbind('resize', this.get('_recomputeStyle'));
      },
      style: (function() {
        var column, index, notifications, rightPx, row, topPx, unitHeight, unitWidth, unitsPerColumn, viewportHeight;
        notifications = this.get('parentView.content').rejectProperty('closed', true);
        index = notifications.indexOf(this.get('content'));
        viewportHeight = $(window).height();
        unitHeight = 80;
        unitWidth = 320;
        unitsPerColumn = Math.floor(viewportHeight / unitHeight);
        column = Math.floor(index / unitsPerColumn);
        row = index % unitsPerColumn;
        if (index === -1) {
          return '';
        }
        topPx = row * unitHeight;
        rightPx = column * unitWidth;
        return 'top: ' + topPx + 'px; right: ' + rightPx + 'px;';
      }).property('parentView.content.@each.closed'),
      /*
      This is simply computed property for mapping a meaningful type name to a FontAwesome CSS class.
      */

      iconType: (function() {
        var hash, type;
        type = this.get('content.type');
        hash = {
          'info': 'fa-bullhorn',
          'success': 'fa-check',
          'warning': 'fa-exclamation',
          'danger': 'fa-times'
        };
        return hash[type] || '';
      }).property('content.type'),
      actions: {
        close: function() {
          this.set('isOpaque', false);
          return setTimeout((function() {
            this.get('parentView.content').removeObject(this.get('content'));
            return clearTimeout(this.get("timeoutId"));
          }).bind(this), 300);
        }
      }
    })
  });

  Ember.Handlebars.helper('bs-growl-notifications', Bootstrap.GrowlNotifications);

  /*
  A manager that is responsible for getting told about new notifications and storing them within an array.
  */


  Bootstrap.GNM = Bootstrap.GrowlNotificationManager = Ember.Object.create({
    /*
    @property {Array} A global array for storing notification objects.
    */

    notifications: Ember.A(),
    /*
    An exposed method for pushing new notification.
    @param title {String} leading text
    @param sub {String} supporting text
    @param type {String} classification; used for which icon to show
    */

    push: function(title, sub, type) {
      var notif;
      type = type != null ? type : type = 'info';
      notif = Bootstrap.Notification.create({
        title: title,
        sub: sub,
        type: type,
        closed: false
      });
      return this.get('notifications').pushObject(notif);
    }
  });

  /*
  An object that represents a notification to be displayed.
  */


  Bootstrap.GrowlNotification = Ember.Object.extend();

}).call(this);
