# Panel

> While not always necessary, sometimes you need to put your DOM in a box. For those situations, try the panel component.
<small>By Bootstrap</small>

## Basic

<div class="bs-example">
    {{#bs-panel heading="Simple Panel" footer="Panel Footer"}}
        <p>Panel content goes here...!</p>
    {{/bs-panel}}
</div>

``` html
\{\{#bs-panel heading="Simple Panel" footer="Panel Footer"\}\}
    <p>Panel content goes here...!</p>
\{\{/bs-panel\}\}
```

## Contextual alternatives

> Like other components, easily make a panel more meaningful to a particular context by adding any of the contextual state classes.
<small>By Bootstrap</small>

<div class="bs-example">
    {{#bs-panel heading="Primary Panel" type="primary"}}
        <p>Panel content.</p>
    {{/bs-panel}}
    {{#bs-panel heading="Success Panel" type="success"}}
        <p>Panel content.</p>
    {{/bs-panel}}
    {{#bs-panel heading="Info Panel" type="info"}}
        <p>Panel content.</p>
    {{/bs-panel}}
    {{#bs-panel heading="Warning Panel" type="warning"}}
        <p>Panel content.</p>
    {{/bs-panel}}
    {{#bs-panel heading="Danger Panel" type="danger"}}
        <p>Panel content.</p>
    {{/bs-panel}}
</div>

``` html
    \{\{#bs-panel heading="Primary Panel" type="primary"\}\}
        <p>Panel content.</p>
    \{\{/bs-panel\}\}
    \{\{#bs-panel heading="Success Panel" type="success"\}\}
        <p>Panel content.</p>
    \{\{/bs-panel\}\}
    \{\{#bs-panel heading="Info Panel" type="info"\}\}
        <p>Panel content.</p>
    \{\{/bs-panel\}\}
    \{\{#bs-panel heading="Warning Panel" type="warning"\}\}
        <p>Panel content.</p>
    \{\{/bs-panel}}
    \{\{#bs-panel heading="Danger Panel" type="danger"\}\}
        <p>Panel content.</p>
    \{\{/bs-panel\}\}
```

## Dismissable Panels

This goes beyond what Bootstrap offers and let you create a closable panels by adding the `dismiss=true` property

<div class="bs-example">
    {{#bs-panel heading="Primary Panel" type="primary" dismiss=true onClose="panelClosed"}}
        <p>Panel content.</p>
    {{/bs-panel}}
</div>


``` html
\{\{#bs-panel heading="Primary Panel" type="primary" dismiss=true onClose="panelClosed"\}\}
    <p>Panel content.</p>
\{\{/bs-panel\}\}
```

## Clickable Panels

Panels can also be clickable, the click is propagated to the _current controller_ via the _clicked_ property


<div class="bs-example">
    {{#bs-panel heading="Primary Panel" type="primary" clicked="panelClicked"}}
        <p>Panel content.</p>
    {{/bs-panel}}
</div>

``` html
\{\{#bs-panel heading="Primary Panel" type="primary" clicked="panelClicked"\}\}
    <p>Panel content.</p>
\{\{/bs-panel\}\}
```

## Collapsible Panels

Panels can be collapsible, to enable collapsible support set `collapsible=true` on the component tag:

<div class="bs-example">
{{#bs-panel heading="Simple Panel" collapsible=true dismiss=true footer="Panel Footer"}}
    <p>Panel content goes here...!</p>
{{/bs-panel}}
</div>

``` html
\{\{#bs-panel heading="Simple Panel" collapsible=true dismiss=true footer="Panel Footer"\}\}
    <p>Panel content goes here...!</p>
\{\{/bs-panel\}\}
```

Collapsible panels can also be closed by default by setting `open=false`.

<div class="bs-example">
{{#bs-panel heading="Open me!" collapsible=true dismiss=true open=false}}
    <p>IM OPEN NOW!</p>
{{/bs-panel}}
</div>

``` html
\{\{#bs-panel heading="Simple Panel" collapsible=true dismiss=true footer="Panel Footer"\}\}
    <p>Panel content goes here...!</p>
\{\{/bs-panel\}\}
```
