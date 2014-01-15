Bootstrap.BsPageHeaderComponent = Ember.Component.extend(
    layoutName: 'components/bs-page-header'
    classNames: ['page-header']
)

Ember.Handlebars.helper 'bs-page-header', Bootstrap.BsPageHeaderComponent