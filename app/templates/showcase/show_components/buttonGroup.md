# Button Group

To wrap a series of buttons, use the _bs-btn-group_ component.

## Standard

<div class="bs-example">
    {{bs-btn-group contentBinding="options" selectedBinding="selected"}}
    <br/>
    Controller say selected item is: {{selected}}
</div>

_content_ is an array of options, each option is rendered as a _button_ tag.

**TODO: SHOW CODE**

## Icons

It is possible to set an icon for the selected button in a group or/and an icon for the in-active buttons by
setting the `icon_active` and/or `icon_inactive` properties to the icon class name.

<div class="bs-example">
    {{bs-btn-group icon_inactive="fa fa-square-o" icon_active="fa fa-check-square-o" contentBinding="options" selectedBinding="selected"}}
    <br/>
    Controller say selected item is: {{selected}}
</div>

```html
<div class="bs-example">
    \{\{bs-btn-group icon_inactive="fa fa-square-o" icon_active="fa fa-check-square-o" contentBinding="options" selectedBinding="selected"\}\}
    <br/>
    Controller say selected item is: \{\{selected\}\}
</div>
```

## Button Toolbar

Combine sets of bs-btn-groups into a bs-btn-toolbar for more complex components.

<div class="bs-example">
    {{#bs-btn-toolbar}}
        {{bs-btn-group contentBinding="options" selectedBinding="selected"}}
        {{bs-btn-group contentBinding="options2" selectedBinding="selected"}}
    {{/bs-btn-toolbar}}
</div>

## Sizing

You can set size in the group level instead of setting size per button.

<div class="bs-example">
    {{#bs-btn-toolbar}}
        {{bs-btn-group size="lg" contentBinding="options" selectedBinding="selected"}}
    {{/bs-btn-toolbar}}
    {{#bs-btn-toolbar}}
        {{bs-btn-group contentBinding="options" selectedBinding="selected"}}
    {{/bs-btn-toolbar}}
    {{#bs-btn-toolbar}}
        {{bs-btn-group small=true contentBinding="options" selectedBinding="selected"}}
    {{/bs-btn-toolbar}}
    {{#bs-btn-toolbar}}
        {{bs-btn-group size="xs" contentBinding="options" selectedBinding="selected"}}
    {{/bs-btn-toolbar}}
</div>


## Vertical variation

Make a set of buttons appear vertically stacked rather than horizontally by adding `vertical=true`.

<div class="bs-example">
    {{bs-btn-group contentBinding="options" selectedBinding="selected" vertical=true}}
</div>

## Buttons with Metadata

It is possible to provide extra metadata per button in the group.

<div class="bs-example">
    {{#bs-btn-toolbar}}
        {{bs-btn-group size="lg" contentBinding="optionsWithMeta" selectedBinding="selected"}}
    {{/bs-btn-toolbar}}
</div>

``` html
\{\{bs-btn-group size="lg" contentBinding="optionsWithMeta" selectedBinding="selected"\}\}
```

_Controller's code_:

``` javascript

Showcase.ShowComponentsButtonGroupController = Ember.Controller.extend({
  optionsWithMeta: [
    Ember.Object.create({title: 'Create', type: 'primary'}),
    Ember.Object.create(({title: 'Destroy', type: 'danger'})
  ]
});
```
