Bootstrap.BsPill = Bootstrap.ItemView.extend(Bootstrap.NavItem, Bootstrap.ItemSelection,
    template: Ember.Handlebars.compile '''
        {{#if view.content.linkTo}}
            {{#if view.parentView.dynamicLink}}
                {{#link-to view.content.linkTo model}}{{view.title}}{{/link-to}}
            {{else}}
                {{#link-to view.content.linkTo}}{{view.title}}{{/link-to}}
            {{/if}}
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