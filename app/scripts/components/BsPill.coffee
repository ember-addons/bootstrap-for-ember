Bootstrap.BsPill = Bootstrap.ItemView.extend(Bootstrap.NavItem, Bootstrap.ItemSelection,
    template: Ember.Handlebars.compile('{{view view.pillAsLinkView}}')

    pillAsLinkView: Ember.View.extend(
        tagName: 'a'
        template: Ember.Handlebars.compile('{{view.parentView.title}}')
        attributeBindings: ['href']
        href: "#"
    )
)