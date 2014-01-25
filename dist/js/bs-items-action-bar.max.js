(function() {
  Bootstrap.ItemsActionBar = Ember.CollectionView.extend({
    classNames: 'btn-toolbar',
    role: 'toolbar',
    selectedItems: [],
    selection: (function() {
      var items;
      items = this.get('selectedItems');
      if (items == null) {
        return [];
      }
      if (Array.isArray(items)) {
        return items;
      } else {
        return [items];
      }
    }).property('selectedItems'),
    itemViewClass: Ember.CollectionView.extend({
      tagName: ['div'],
      classNames: ['btn-group'],
      itemViewClass: Ember.View.extend({
        tagName: 'button',
        classNames: ['btn', 'btn-default'],
        attributeBindings: ['disabled'],
        template: Ember.Handlebars.compile("                {{#if view.content.transitionTo}}                    {{link-to view.content.title view.content.transitionTo tagName='div'}}                {{else}}                    {{view.content.title}}                {{/if}}            "),
        disabled: (function() {
          var _base;
          return typeof (_base = this.get('content.disabled')) === "function" ? _base(this.get('parentView.parentView.selection')) : void 0;
        }).property('parentView.parentView.selection.@each', 'parentView.parentView.selection'),
        click: function() {
          if (this.get('content.clickActionName') != null) {
            return this.get('controller').send(this.get('content.clickActionName'), this.get('parentView.parentView.selection'));
          } else if (this.get('content.click')) {
            return this.get('content.click')(this.get('parentView.parentView.selection'));
          }
        }
      })
    })
  });

  Ember.Handlebars.helper('bs-items-action-bar', Bootstrap.ItemsActionBar);

}).call(this);
