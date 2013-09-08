# List Group
>List groups are a flexible and powerful component for displaying not only simple lists of elements, but complex ones with custom content.
<small>By Bootstrap</small>

All list items are linkable and selection can easily be observed


## Simple
The most basic list group is simply an unordered list with list items.

<div class="bs-example">
{{bs-list-group contentBinding="listSimple" selectedBinding="selected"}}

Selected: {{selected}}
</div>

``` html
\{\{bs-list-group contentBinding="listSimple"\}\}
```
Controller's code:

``` javascript
Showcase.ShowComponentsListGroupController = Ember.Controller.extend({
    listSimple: Ember.A(['Cras justo odio', 'Dapibus ac facilisis in', 'Morbi leo risus'])
})
```

## Badges

Each item in the list can have badge component that will automatically be positioned on the right.

<div class="bs-example">
    {{bs-list-group contentBinding="listWithBadges"}}
</div>

``` html
\{\{bs-list-group contentBinding="listWithBadges"\}\}
```

Controller's code:
``` javascript
Showcase.ShowComponentsListGroupController = Ember.Controller.extend({
  listWithBadges: Ember.A([
    Ember.Object.create({title: 'Inbox', badge: '45'}),
    Ember.Object.create({ title: 'Sent', badge: '33'})
  ])
});
```

## List with Sub Text

Items can have a sub text enabled if an item metadata has the 'sub' property.

<div class="bs-example">
    {{bs-list-group contentBinding="listWithSub"}}
</div>

``` html
\{\{bs-list-group contentBinding="listWithSub"\}\}
```

Controller's code:
``` javascript
Showcase.ShowComponentsListGroupController = Ember.Controller.extend({
  listWithSub: Ember.A([
    Ember.Object.create({title: 'Inbox', badge: '45'}),
    Ember.Object.create({ title: 'Sent', badge: '33'})
  ])
});
```