Bootstrap.BsPill = Bootstrap.ItemView.extend(Bootstrap.NavItem, Bootstrap.ItemSelection,
    template: Ember.Handlebars.compile '''
        {{#if view.content.linkTo}}
            {{#linkTo view.content.linkTo}}{{view.title}}{{/linkTo}}
        {{else}}
            {{view view.pillAsLinkView}}
        {{/if}}
    '''

    pillAsLinkView: Ember.View.extend(
        tagName: 'a'
        template: Ember.Handlebars.compile('{{view.parentView.title}}')
        attributeBindings: ['href']
        href: "#"
    )
)