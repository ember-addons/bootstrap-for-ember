# Pills

[Pills](http://getbootstrap.com/components/#nav-pills) are a button-like navigation style,

Bootstrap doesn't dictate nor assist with how you respond when an item is selected in the Pills navigation,
But using _bs-pills_ helps by making the navigation more interactive by providing selection bindings and styling the
active element, see examples below.

<div class="bs-example">
    {{bs-pills contentBinding="content" selectedBinding="selected"}}
    Selected: {{selected}}
</div>

``` html

\{\{bs-pills contentBinding="content" selectedBinding="selected"\}\}

Selected: \{\{selected\}\}
```

_content_ and _selected_ are properties in the current _controller_


* The _content_ controller property is an array of strings where each string is rendered as a possible item selection.
* When an item selection is changed, the _selected_ property in the current _controller_ will be set with the value of the selected item.

Here's the controller sample code:

``` javascript
Showcase.ShowComponentsPillsController = Ember.Controller.extend({
  content: ['Home', 'Profile', 'Messages'],
  contentChanged: (function() {
    return console.log("Selection has changed to: " + (this.get('selected')));
  }).observes('selected')
});
```

# Stacked

> Pills are also vertically stackable. Just add `stacked=true``

<div class="bs-example">
    {{bs-pills contentBinding="content" selectedBinding="selected" stacked=true style="max-width: 300px;"}}
</div>

``` html
    \{\{bs-pills contentBinding="content" selectedBinding="selected" stacked=true style="max-width: 300px;"\}\}
```


# Justified

> Easily make tabs or pills equal widths of their parent with setting `justified=true`

<div class="bs-example">
    {{bs-pills contentBinding="content" selectedBinding="selected" justified=true}}
</div>

``` html
    \{\{bs-pills contentBinding="content" selectedBinding="selected" justified=true\}\}
```

# Disabled links

Bootstrap doesn't stop the propagation of the redirection of disabled links for you:

>  This class will only change the _anchor_'s appearance, not its functionality. Use custom JavaScript to disable links here.
<small>[By Bootstrap](http://getbootstrap.com/components/#nav-disabled-links)</small>


But using _bs-pills_ ease your pain by giving you the opportunity to bind the disable state of each item by providing extra metadata per item, clicking a disabled item disables the links too.

To define links (items) as disabed, you need to provide extra metadata per defined item in the _contentBinding_ property.

<div class="bs-example">
    {{bs-pills contentBinding="content1" selectedBinding="selected1"}}
    {{bs-button clicked="disableHome" title="Disable Home"}}
</div>

``` html
\{\{bs-pills contentBinding="content" selectedBinding="selected"\}\}
\{\{bs-button clicked="disableHome" content="Disable Home"\}\}
```

Controller sample code:

``` javascript

Showcase.ShowComponentsPillsController = Ember.Controller.extend({
  init: function() {
    this._super();
    this.set('content', Ember.A([
      Ember.Object.create({title: 'Home',disabled: false}),
      Ember.Object.create({title: 'Admin',disabled: true})
    ]));
    this.set('selected', this.get('content').objectAt(0));
  },

  disableHome: function() {
    this.get('content').objectAt(0).set('disabled', true);
  }
});
```

