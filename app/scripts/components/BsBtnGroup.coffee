###
Button Group.

In its simple form, each item in the button group is a Bootstrap.Button component,
In case this is a Radio, each item is rendered as a label.
###
Bootstrap.BsBtnGroup = Bootstrap.ItemsView.extend(Bootstrap.SizeSupport, Bootstrap.ItemsSelection,
    classTypePrefix: ['btn-group']
    classNames: ['btn-group']
    classNameBindings: ['vertical:btn-group-vertical']
    #TODO: This is a hack until it will be possible to extend from component as it looses the template association
    #see https://github.com/emberjs/ember.js/issues/3376
    itemViewClass: Bootstrap.BsButtonComponent.extend(Bootstrap.ItemValue, Bootstrap.ItemSelection,
        layoutName: 'components/bs-button'
    )
)

Ember.Handlebars.helper 'bs-btn-group', Bootstrap.BsBtnGroup