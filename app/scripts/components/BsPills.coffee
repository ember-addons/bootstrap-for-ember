Bootstrap.BsPills = Bootstrap.ItemsView.extend(Bootstrap.Nav,
    navType: 'pills'
    classNameBindings: ['stacked:nav-stacked', 'justified:nav-justified']
    attributeBindings: ['style']

    itemViewClass: Bootstrap.BsPill
)

Ember.Handlebars.helper 'bs-pills', Bootstrap.BsPills