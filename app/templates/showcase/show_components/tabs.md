# Tabs

Tabs are like Pills but styled differently,
The share exactly the same concepts, so this page doesn't repeat everything, visit Pills for the complete details.

## Simple Tabs

<div class="bs-example">
    {{bs-tabs contentBinding="content" selectedBinding="selected"}}

    <br/>
    **Selected**: {{selected}}
</div>


``` html
    \{\{bs-tabs contentBinding="content" selectedBinding="selected"\}\}
```

Controller's code:

``` javascript
Showcase.ShowComponentsTabsController = Ember.Controller.extend({
  content: ['Home', 'Profile', 'Messages']
});
```

## Panes

Please see {{#linkTo "show_components.tabs-panes"}}Tab Panes{{/linkTo}} for more info about Tab Panes.
