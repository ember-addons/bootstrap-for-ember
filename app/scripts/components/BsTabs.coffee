Bootstrap.BsTabs = Bootstrap.ItemsView.extend(Bootstrap.Nav,
    navType: 'tabs'
    classNameBindings: ['justified:nav-justified']
    attributeBindings: ['style']

    itemViewClass: Bootstrap.BsPill
)

Ember.Handlebars.helper('bs-tabs', Bootstrap.BsTabs)