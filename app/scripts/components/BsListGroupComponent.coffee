Bootstrap.BsListGroupComponent = Bootstrap.ItemsView.extend(
    tagName: 'ul'
    classNames: ['list-group']
    itemViewClass: Bootstrap.ItemView.extend(Bootstrap.ItemSelection,
        classNames: ['list-group-item']
        template: Ember.Handlebars.compile '''
            {{#if view.badge}}
                {{bs-badge contentBinding="view.badge"}}
            {{/if}}
            {{#if view.sub}}
                <h4 class="list-group-item-heading">{{view.title}}</h4>
                <p class="list-group-item-text">{{view.sub}}</p>
            {{else}}
                {{view.title}}
            {{/if}}
        '''

        badge: (->
            #TODO: Consolidate with ItemView
            content = @get('content')
            return null unless Ember.typeOf(content ) is 'instance' or Ember.canInvoke(content, 'get')
            content.get 'badge'
        ).property('content')

        sub: (->
            #TODO: Consolidate with ItemView
            content = @get('content')
            return null unless Ember.typeOf(content ) is 'instance' or Ember.canInvoke(content, 'get')
            content.get 'sub'
        ).property('content')
    )
)

Ember.Handlebars.helper('bs-list-group', Bootstrap.BsListGroupComponent)