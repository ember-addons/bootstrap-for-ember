###
Button Group.

In its simple form, each item in the button group is a Bootstrap.Button component,
In case this is a Radio, each item is rendered as a label.
###
Bootstrap.BsBtnGroup = Bootstrap.ItemsView.extend(Bootstrap.SizeSupport, Bootstrap.ItemsSelection,
    classTypePrefix: ['btn-group']
    classNames: ['btn-group']
    classNameBindings: ['vertical:btn-group-vertical']
    #itemViewClass: Bootstrap.BsButtonComponent.extend(Bootstrap.ItemValue, Bootstrap.ItemSelection,
    #)
    #TODO: This is a hack until it will be possible to extend from component as it looses the template association
    itemViewClass: Ember.View.extend(Bootstrap.TypeSupport, Bootstrap.ItemValue, Bootstrap.ItemSelection,
        template: Ember.Handlebars.compile('{{view.title}}')
        tagName: 'button'
        classNames: ['btn']
        classNameBindings: ['blockClass']
        classTypePrefix: 'btn'
        typeBinding: 'content.type'

        title: (->
            content = @get('content')
            return content unless Ember.typeOf(content) is 'instance' or Ember.canInvoke(content, 'get')
            content.get 'title'
        ).property('content')

    )

)

Ember.Handlebars.helper('bs-btn-group', Bootstrap.BsBtnGroup)