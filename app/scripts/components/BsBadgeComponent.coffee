Bootstrap.BsBadgeComponent = Ember.Component.extend(Bootstrap.TypeSupport,
    layoutName: 'components/bs-badge'
    tagName: 'span'
    classNames: ['badge']
    classTypePrefix: 'badge'
)

Ember.Handlebars.helper 'bs-badge', Bootstrap.BsBadgeComponent