#Popover & Tooltips

## Setup

For Popover support, it is required to adapt the _application route_ and add a named outlet to your main template and reference a controller that extends from `Bootstrap.TooltipBoxController`

``` javascript
//Create some controller in your app that references _Bootstrap.TooltipBoxController_
App.TooltipBoxController = Bootstrap.TooltipBoxController

//Application route
App.ApplicationRoute = Ember.Route.extend({
    renderTemplate: function() {
        // Render default outlet
        this.render();
        // render extra outlets
        var controller = this.controllerFor('tooltip-box');
        this.render("bs-tooltip-box", {
            outlet: "bs-tooltip-box",
            controller: controller,
            into: "application" // important when using at root level
        });
    }
});

```

## Tooltips

### Simple content

<div class="bs-example">
<p class="muted" style="margin-bottom: 0;">Here is <a href="#" {{bs-bind-tooltip content="A tooltip!"}}>a very</a> link with a tooltip,.
    You can mix as many <a href="#" {{bs-bind-tooltip title="Another tooltip!"}}>tooltips</a> as you wish.
</p>
</div>

``` html
<p class="muted" style="margin-bottom: 0;">
    Here is <a href="#" \{\{bs-bind-tooltip content="A tooltip!"\}\}>a very</a> link with a tooltip,.
    You can mix as many <a href="#" \{\{bs-bind-tooltip title="Another tooltip!"\}\}>tooltips</a> as you wish.
</p>
```

### Bindings & Sticky

You can bind the value of the tooltip to an object and make the tooltip sticky by:

<div class="bs-example">
    <a href="#" {{bs-bind-tooltip testObject.sticky}}>Hover me for a sticky tooltip!</a>
</div>

In template:

``` html
<a href="#" \{\{bs-bind-tooltip testObject.sticky\}\}>Hover me for a sticky tooltip!</a>
```

In controller:

``` javascript
    stickyTooltip: Ember.Object.createWithMixins({
        popover: (function() {
          return Ember.Object.create({
            user: this,
            content: 'know this is a sticky tooltip! You can hover over it.',
            trigger: 'hover',
            sticky: true
          });
        }).property()
      })
```

## Popovers

### Examples

Here are some examples for popovers:

<div class="bs-example">
    <ul class="list-group" style="width:250px">
        <li class="list-group-item" {{bs-bind-popover hoverPop}}>
                 Hover for a sticky popup
        </li>
        <li class="list-group-item" {{bs-bind-popover clickPop}}>
                 Click for a popup
        </li>
        <li class="list-group-item" {{bs-bind-popover templPop}}>
                 Click for a popup with template
        </li>
    </ul>
</div>

In template:
``` html
<ul class="list-group" style="width:250px">
    <li class="list-group-item" \{\{bs-bind-popover hoverPop\}\}>
             Hover for a sticky popup
    </li>
    <li class="list-group-item" \{\{bs-bind-popover clickPop\}\}>
             Click for a popup
    </li>
    <li class="list-group-item" \{\{bs-bind-popover templPop\}\}>
             Click for a popup with template
    </li>
</ul>
```

In controller:

``` javascript
  hoverPop: Ember.Object.create({
    title: "I'm a title!",
    content: "And i'm a content!",
    trigger: "hover",
    placement: "right",
    sticky: true
  }),

  clickPop: Ember.Object.create({
    title: "Clickable!",
    content: "This is a clickable popover",
    placement: "left"
  }),

  templPop: Ember.Object.create({
      firstName: 'numbers',
      title: 'Popover with Template',
      template: 'numbers:<ul>' +
              '\{\{#each val in content.numbers\}\}' +
              '   <li>\{\{val\}\}</li>' + '\{\{/each\}\}' +
              '</ul>',
      content: {
        numbers: [1, 2, 3]
      }
  })

```


## Object Options

Following are the options that back a tooltip/popover entry:

<div class="table-responsive">
    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th style="width: 100px;">Property Name</th>
                <th style="width: 100px;">Type</th>
                <th style="width: 50px;">Default</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>html</td>
                <td>boolean</td>
                <td>false</td>
                <td>Insert HTML into the popover.</td>
            </tr>
            <tr>
                <td>placement</td>
                <td>string | function</td>
                <td>'right'</td>
                <td>how to position the popover - top | bottom | left | right | auto.<br> When "auto" is specified, it will dynamically reorient the popover. For example, if placement is "auto left", the popover will display to the left when possible, otherwise it will display right.</td>
            </tr>
            <tr>
                <td>trigger</td>
                <td>string</td>
                <td>'click' for popover| 'hover' for tooltip</td>
                <td>how popover is triggered - click | hover | focus | manual</td>
            </tr>
            <tr>
                <td>sticky</td>
                <td>boolean</td>
                <td>false</td>
                <td>To be used when trigger is 'hover'.
                    When the tooltip appears you have 100ms to hover over it and only after you leave the popover/tooltip it will disappear</td>
            </tr>
            <tr>
                <td>show</td>
                <td>boolean</td>
                <td>false</td>
                <td>To be used when trigger is 'manual'.
                    Will show the tip when true, hide when false.
                    The property will be observed for changes with "addObserver"
                </td>
            </tr>
            <tr>
                <td>title</td>
                <td>string</td>
                <td>''</td>
                <td></td>
            </tr>
            <tr>
                <td>content</td>
                <td>string | function</td>
                <td>''</td>
                <td></td>
            </tr>
            <tr>
                <td>template</td>
                <td>string</td>
                <td>null</td>
                <td>Use this template to display. The context will be the popover/tooltip. The data is available in content.*</td>
            </tr>
        </tbody>
    </table>
</div>



