Showcase.ShowComponentsPopoverController = Ember.Controller.extend(
    testObject: Ember.Object.createWithMixins
        sticky: (->
            return Ember.Object.create(
                user: this,
                content: 'know this is a sticky tooltip! You can hover over it.',
                trigger: 'hover',
                sticky: true
            )
        ).property()

    user: Ember.Object.create
            firstNameBinding: 'content.name'
            title: 'rename'
            template: 'name: {{input type="text" value=content.name}}'
            content:
                name: 'John'
            trigger: 'hover'
            sticky: true


    hoverPop: Ember.Object.create
        title: "I'm a title!"
        content: "And i'm a content!"
        trigger: "hover"
        placement: "right"
        sticky: true

    clickPop: Ember.Object.create
        title: "Clickable!"
        content: '<h1>Hello</h1><small>This is a clickable popover with html content!</small>'
        placement: "left"
        html: true

    templPop: Ember.Object.create
        firstName: 'numbers'
        title: 'Popover with Template'
        template:   'numbers:<ul>' +
                    '{{#each val in content.numbers}}' +
                    '   <li>{{val}}</li>' +
                    '{{/each}}' +
                    '</ul>'
        content:
            numbers: [1,2,3]
)