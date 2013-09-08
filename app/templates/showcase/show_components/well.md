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

## Component Properties

<div class="table-responsive">
    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th style="width: 150px;">Property</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>large</td>
                <td>If true, a large well _will_ be rendered by adding the **well-lg** class.</td>
            </tr>
            <tr>
                <td>small</td>
                <td>If true, a small _well_ will be rendered by adding the **well-sm** class.</td>
            </tr>
            <tr>
                <td>clicked</td>
                <td>Triggers the specified function name on the **controller** immediately when user clicks the area of the well.</td>
            </tr>
        </tbody>
    </table>
</div>
