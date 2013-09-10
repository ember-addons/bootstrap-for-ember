Showcase.ShowComponentsGrowlNotifController = Ember.Controller.extend(
    actions:
        pushInfo: () ->
            Bootstrap.GNM.push('INFO!', 'Hello, this is just an info message.', 'info')
        pushSuccess: () ->
            Bootstrap.GNM.push('SUCCESS!', 'Successfully performed operation!', 'success')
        pushWarn: () ->
            Bootstrap.GNM.push('WARN!', 'Could not perform operation!', 'warning')
        pushDanger: () ->
            Bootstrap.GNM.push('Danger!', 'System is halting!', 'danger')
)