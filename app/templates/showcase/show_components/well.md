# Well

## Default Well

<p>Here is a default well, but **pay attention** that it is clickable, the click will be propagated to the **controller**.</p>

<div class="bs-example">
    {{#bs-well clicked="wellClick"}}
    I am in a well, click me!
    {{/bs-well}}
</div>

``` html
\{\{#bs-well clicked="wellClick"\}\}
I am in a well!
\{\{/bs-well\}\}
```


<code>wellClick</code> is the function name in the **controller**.

## Optional classes

As explained by Bootstrap:
> Control padding and rounded corners with two optional modifier classes.

### Large Well

<div class="bs-example">
    {{#bs-well large=true}}
    Look, I'm in a large well!
    {{/bs-well}}
</div>

``` html
\{\{#bs-well large=true\}\}
Look, I'm in a large well!
\{\{/bs-well\}\}
```

<b>You can set large well by adding <code>class="well-lg"</code> or just set the <code>large</code> property to true</b>

### Small Well

<div class="bs-example">
    {{#bs-well small=true}}
    Look, I'm in a small well!
    {{/bs-well}}
</div>

``` html
\{\{#bs-well small=true\}\}
Look, I'm in a small well!
\{\{/bs-well\}\}
```

<b>You can set large well by adding <code>class="well-sm"</code> or just set the <code>small</code> property to true</b>