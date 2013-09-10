Showcase.ShowComponentsNotificationsController = Ember.Controller.extend(
    actions:
        pushInfo: () ->
            Bootstrap.NM.push('Hello, this is just an info message.', 'info')
        pushWarn: () ->
            Bootstrap.NM.push('Could not perform operation!', 'warning')
        pushSuccess: () ->
            Bootstrap.NM.push('Successfully performed operation!', 'success')
        pushDanger: () ->
            Bootstrap.NM.push('Danger! system is halting!', 'danger')
)