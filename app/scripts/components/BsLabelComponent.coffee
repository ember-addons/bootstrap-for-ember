Bootstrap.BsLabelComponent = Ember.Component.extend(Bootstrap.TypeSupport,
    layoutName: 'components/bs-label'
    tagName: 'span'
    classNames: ['label']
    classTypePrefix: 'label'
)

Ember.Handlebars.helper 'bs-label', Bootstrap.BsLabelComponent