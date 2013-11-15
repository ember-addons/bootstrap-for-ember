# Growl like Notifications


_Growl Notifications_ is not a Bootstrap component but is mandatory for almost every web application.

_Growl Notifications_ are just like the _Notification_ component but messages that are rendered as small boxes on the right top of the screen, they fade in for a short period of time with a title, sub text and icon and then fade out.

To use growl notifications, put somewhere in your _application_ template the _bs-growl-notifications_ component.

``` html
\{\{bs-growl-notifications\}\}
```

Then use the _GrowlNotificationManager_ / _GNM_ to push new notifications with a message and type.

<div class="bs-example">
    {{bs-button clicked="pushInfo" title="Push Info"}}
    {{bs-button clicked="pushWarn" title="Push Warning"}}
    {{bs-button clicked="pushSuccess" title="Push Success"}}
    {{bs-button clicked="pushDanger" title="Push Danger"}}
</div>

Controller code:


``` javascript
Showcase.ShowComponentsGrowlNotifController = Ember.Controller.extend({
  pushInfo: function() {
    Bootstrap.GNM.push('INFO!', 'Hello, this is just an info message.', 'info');
  },
  pushSuccess: function() {
    Bootstrap.GNM.push('SUCCESS!', 'Successfully performed operation!', 'success');
  },
  pushWarn: function() {
    Bootstrap.GNM.push('WARN!', 'Could not perform operation!', 'warning');
  },
  pushDanger: function() {
    Bootstrap.GNM.push('Danger!', 'System is halting!', 'danger');
  }
});
```

You can control the visibility duration of each message by specifying the _showTime_ property.


## Component Files

* _css/bs-growl-notifications.min.css_
* _js/bs-growl-notifications.min.js_

## Component Properties

<div class="table-responsive">
    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th style="width: 150px;">Property</th>
                <th>Description</th>
                <th>Default</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>showTime</td>
                <td>A number in _ms_ that defines how long the notification is displayed before it starts to fade out.</td>
                <td>10 seconds</td>
            </tr>
        </tbody>
    </table>
</div>
