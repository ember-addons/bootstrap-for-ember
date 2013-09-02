# Progress Bar

> Provide up-to-date feedback on the progress of a workflow or action with simple yet flexible progress bars.
<small>By Bootstrap</small>

## Basic usage

<div class="bs-example">
    {{bs-progress progress=60}}
</div>

``` html
    \{\{bs-progress progress=60\}\}
```

**Simple as that! a single short line, compared to [Bootstarp Tags](http://getbootstrap.com/components/#progress) 5 long lines that
produces the same result.**

The progress component respects all _aria_ tags mentioned in _Bootstrap_ documentation.

---

> Progress bars use some of the same button and alert classes for consistent styles
<small>By Bootstrap</small>

<div class="bs-example">
    {{bs-progress progress=40 type="success"}}
    {{bs-progress progress=20 type="info"}}
    {{bs-progress progress=60 type="warning"}}
    {{bs-progress progress=80 type="danger"}}
</div>


``` html
    \{\{bs-progress progress=40 type="success"\}\}
    \{\{bs-progress progress=20 type="info"\}\}
    \{\{bs-progress progress=60 type="warning"\}\}
    \{\{bs-progress progress=80 type="danger"\}\}
```


---

The _progress_ property can be bound to a controller property:

<div class="bs-example">
    {{bs-progress progressBinding="prog"}}
    {{bs-button clicked="increment" title="Increment!"}}
</div>

``` html
    \{\{bs-progress progressBinding="prog"\}\}
    \{\{bs-button clicked="increment" content="Increment!"\}\}
```

Controller sample code:

``` javascript
Showcase.ShowComponentsProgressbarController = Ember.Controller.extend({
  prog: 0,
  incrementBy: 20,
  increment: function() {
    if (this.prog < 100) {
      return this.incrementProperty("prog", this.incrementBy);
    } else {
      return this.set("prog", this.incrementBy);
    }
  }
});
```

## Striped

> Uses a gradient to create a striped effect. Not available in IE8.
<small>By Bootstrap</small>

This is simply done by setting the _stripped=true_ property.

<div class="bs-example">
    {{bs-progress progress=40 type="success" stripped=true}}
    {{bs-progress progress=20 type="info" stripped=true}}
    {{bs-progress progress=60 type="warning" stripped=true}}
    {{bs-progress progress=80 type="danger" stripped=true}}
</div>


## Animated

In addition to _stripped=true_, add _animated=true_ property to animate the stripes right to left.

<div class="bs-example">
    {{bs-progress progress=45 stripped=true animated=true}}
</div>

``` html
    \{\{bs-progress progress=45 stripped=true animated=true\}\}
```

## Stacked

Multiple bars can be placed into the same _bs-progress_ to stack them:

<div class="bs-example">
    {{#bs-progress}}
        {{bs-progressbar type="success" progress="35"}}
        {{bs-progressbar type="warning" progress="20"}}
        {{bs-progressbar type="danger" progress="10"}}
    {{/bs-progress}}
</div>

``` html
    \{\{#bs-progress\}\}
        \{\{bs-progressbar type="success" progress="35"\}\}
        \{\{bs-progressbar type="warning" progress="20"\}\}
        \{\{bs-progressbar type="danger" progress="10"\}\}
    \{\{/bs-progress\}\}
```