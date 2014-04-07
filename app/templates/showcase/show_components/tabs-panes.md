# Tab Panes

Defining {{#link-to "show_components.tabs"}}Tab Component{{/link-to}} covers the Tabs rendering and help you to interact with the selected tab. But usually some content should be rendered as a response for a tab click right?

This is where _Tab Panes_ come into play, a tab pane is the content area of each rendered tab, when a tab is selected, the corresponding _tab pane_ becomes visible, see below for the possible options.


Tab Panes expects a `contentBinding` property just like the _bs-tabs_ component, the _Tabs Panes_ component also must be aware of the _bs-tabs_ component it is bound to by specifying the _items-id_ property set to the _id_ of the corresponding _bs-tabs_

<div class="bs-example">
    {{bs-tabs id="tabs1" contentBinding="tabsMeta" default="Foo"}}
    {{bs-tabs-panes items-id="tabs1" contentBinding="tabsMeta"}}
</div>

``` html
\{\{bs-tabs id="tabs1" contentBinding="tabsMeta" default="Foo"\}\}
\{\{bs-tabs-panes items-id="tabs1" contentBinding="tabsMeta"\}\}
```

* An `id` property is required for the _bs-tabs_.
* The _bs-tabs-panes_ generates a tab pane per element in the _content_ array.
* The `items-id` property must refer to the `id` of the `bs-tabs` component.
* If you like one tab to be activated by default, set the `default` property of the _bs-tabs_ component to a title of the tab you would like to be activated by default.

Here is the controller _tabsPanesOptions_ property:

``` javascript
SomeController = Ember.Controller.extend({
    tabsMeta: Ember.A([
            Ember.Object.create({ title: 'Foo', template: 'tabs/foo-tabpane', controller: 'ShowcaseComponentsTabsFoo'}),
            Ember.Object.create({ title: 'Bar', template: 'tabs/bar-tabpane'})
    ]);
});

The `template: 'some-template'` defines what template to render in the corresponding _Tab Pane_ when the Tab is selected.

```
Note that for the `Foo` tab, a `controller` property was defined, calling `\{\{controller\}\}` within the tab pane template `tabs/foo-tabpane` will point to the specified `ShowcaseComponentsTabsFoo` controller instead of the default controller
which is the controller of the template the `\{\{bs-tabs-panes\}\}` was called from.


Thats all needed! awesome isn't it?
