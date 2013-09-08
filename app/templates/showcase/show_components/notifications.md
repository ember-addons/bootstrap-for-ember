# Notifications

_Notifications_ is not a Bootstrap component but is mandatory for almost every web application.

_Notifications_ are messages that are rendered as _Alerts_, they fade in for a short period of time with some message and type and then they fade out.

Notifications are pushed into an array, so different parts of the application may push notifications to the user
and each will be displayed one after another.

To use notifications, put somewhere in your _application_ template the _bs-notifications_ component.

``` html
\{\{bs-notifications style="z-index: 1000; position: fixed; width: 50%; left: 0; right: 0; margin-left: auto; margin-right: auto; margin-top: 50px;"\}\}
```

How you style the component is up to you, this is just an example for centralizing the notifications on the screen.

Then use the _NotificationManager_ / _NM_ to push new notifications with a message and type.

<div class="bs-example" >
    {{bs-button type="info" clicked="pushInfo" title="Push Info"}}
    {{bs-button type="warning" clicked="pushWarn" title="Push Warning"}}
    {{bs-button type="success" clicked="pushSuccess" title="Push Success"}}
    {{bs-button type="danger" clicked="pushDanger" title="Push Danger"}}
</div>

Controller code:

``` javascript
Showcase.ShowComponentsNotificationsController = Ember.Controller.extend({
  pushInfo: function() {
    return Bootstrap.NM.push('Hello, this is just an info message.', 'info');
  },
  pushWarn: function() {
    return Bootstrap.NM.push('Could not perform operation!', 'warning');
  },
  pushSuccess: function() {
    return Bootstrap.NM.push('Successfully performed operation!', 'success');
  },
  pushDanger: function() {
    return Bootstrap.NM.push('Danger! system is halting!', 'danger');
  }
});
```

During fade out, If user hover with the mouse in the notification area, it will cancel the fade in animation so the user can have more time to read the message, moving the mouse out will retrigger the fade out.

You can control the duration messages are displayed, the fade out and fade in time by providing properties for each, for more info see the properties options below.


## Component Properties

<div class="table-responsive">
    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th style="width: 150px;">Property</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>showTime</td>
                <td>A number in _ms_ that defines how long the notification is displayed before it starts to fade out.</td>
            </tr>
            <tr>
                <td>fadeInTime</td>
                <td>A number in _ms_ that defines how long it takes a notification to fades in.</td>
            </tr>
            <tr>
                <td>fadeOutTime</td>
                <td>A number in _ms_ that defines how long it takes a notification to fade out.</td>
            </tr>
        </tbody>
    </table>
</div>
