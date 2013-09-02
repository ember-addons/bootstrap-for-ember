###
Button Group.

In its simple form, each item in the button group is a Bootstrap.Button component,
In case this is a Radio, each item is rendered as a label.
###
Bootstrap.BsBtnGroup = Bootstrap.ItemsView.extend(Bootstrap.SizeSupport, Bootstrap.ItemsSelection,
    classTypePrefix: ['btn-group']
    classNames: ['btn-group']
    classNameBindings: ['vertical:btn-group-vertical']
    itemViewClass: Bootstrap.BsButtonComponent.extend(Bootstrap.ItemValue, Bootstrap.ItemSelection,
        titleBinding: 'content'
    )
)

Ember.Handlebars.helper('bs-btn-group', Bootstrap.BsBtnGroup)