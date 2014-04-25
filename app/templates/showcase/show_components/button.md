# Button


## Types

<div class="bs-example">
    {{#bs-button}}Content{{/bs-button}}
    {{bs-button title="Inline Text"}}
    {{#bs-button type="primary"}}Primary{{/bs-button}}
    {{#bs-button type="link"}}Link{{/bs-button}}

    <p>All other types such as **info**, **warning**, **danger** are supported.</p>
</div>


``` html
<!-- Standard gray default button with gradient -->
\{\{#bs-button\}\}Content\{\{/bs-button\}\}

<!--Inline text as button content-->
\{\{bs-button title="Inline Text"\}\}

<!-- Provides extra visual weight and identifies the primary action in a set of buttons -->
\{\{#bs-button type="primary"\}\}Primary\{\{/bs-button\}\}

<!-- Deemphasize a button by making it look like a link while maintaining button behavior -->
\{\{#bs-button type="link"\}\}Link\{\{/bs-button\}\}
```


## Sizes

In correspondence with bootstrap css class button sizes `.btn-lg`, `.btn-sm`, or `.btn-xs`, size can simply defined by the _size_ property or use one of the size properties: `small=true`, `large=true`, `xs=true`

<div class="bs-example">
    <p>
        {{bs-button type="primary" size="xs" title="Primary Extra Small Button"}}
        {{bs-button type="info" small=true title="Info Small Button"}}
        {{bs-button type="danger" title="Danger Default size button"}}
        {{#bs-button size="lg"}}Default Large button{{/bs-button}}
    </p>
</div>

``` html
\{\{bs-button type="primary" size="xs" title="Primary Extra Small Button"\}\}
\{\{bs-button type="info" small=true title="Info Small Button"\}\}
\{\{bs-button type="danger" title="Danger Default size button"\}\}
\{\{#bs-button size="lg"\}\}Default Large button\{\{/bs-button\}\}
```

## Icon

<div class="bs-example">
    <p>
        {{bs-button icon="fa fa-check" title="Button with Icon"}}
    <p>
</div>

Simply add an `icon` property to the button meta data, such:

``` html
\{\{bs-button icon="fa fa-check" title="Danger Default size button"\}\}
```

Will render an `<i class="fa fa-check"></i>` tag within the button tag.

## Block Level

block level buttons—those that span the full width of a parent— by adding `block=true`

<div class="bs-example">
    {{#bs-button type="primary" xs=true block=true}}Block Button{{/bs-button}}
</div>

``` html
\{\{#bs-button type="primary" xs=true block=true}}Block Button\{\{/bs-button\}\}
```

## Disbled state

As in Bootstrap, set `disabled="disabled"`/`disabled=true` to make the button unclickable.

<div class="bs-example">
    {{#bs-button type="primary" disabled=true}}Disabled Button{{/bs-button}}
</div>

``` html
\{\{#bs-button type="primary" disabled=true\}\}Disabled Button\{\{/bs-button\}\}
```

Disabled state can also be hooked to a controller property

<div class="bs-example">
    {{bs-button type="primary" title="Click to disable" disabled=isButtonDisabled clicked="disableButton"}}
</div>

``` html
\{\{bs-button type="primary" title="Click to disable" disabled=isButtonDisabled clicked="disableButton"\}\}
```

* `isButtonDisabled` is a boolean property on the controller
* `disableButton` is a function on the controller that sets `isButtonDisabled` to _false_

## Param

It is possible to pass a parameter to the action in the controller that is bound to the click event by using the `clickedParam` property.

<div class="bs-example">
    {{#bs-button type="primary" clicked="buttonWithParam" clickedParamBinding="controller"}}Button with Param{{/bs-button}}
</div>


``` html
\{\{#bs-button type="primary" clicked="buttonWithParam" clickedParamBinding="controller"\}\}Button with Param\{\{/bs-button\}\}
```

Action in controller:

``` javascript
MyController = Ember.Controller.extend({
    actions: {
        buttonWithParam: function(expectedMyself) {
            alert("Passed controller as a param: " + expectedMyself);
        }
    }
)}
```

## State

By Bootstrap:
> Add `data-loading-text="Loading..."` to use a loading state on a button.

Then extra `loading=loadingState` is needed where *loadingState* is a property in the *controller* that returns a string which
defines the current state of the button:

* If `loadingState` property equals `loading` then the button will be disabled and its text will change to the value of the `data-loading-text` button property.
* If its value is `null` then the button will be re-enabled and its text will be modified to the original value defined in the `title` button property.

<div class="bs-example">
    {{bs-button type="primary" data-loading-text="Loading..." loading=loadingState clicked="disableButton" title="Submit" clicked="startLoading"}}
</div>


``` html
\{\{bs-button type="primary" data-loading-text="Loading..." loading=loadingState title="Submit" clicked="startLoading"\}\}
```

<p>In controller:</p>

``` javascript
startLoading: function() {
    var _this = this;
    this.set('loadingState', 'loading');
    return Ember.run.later(function() {
      return _this.set('loadingState', null);
    }, 2000);
}
```

The `loading` property may also return any string that matches one of the `data-foo-text` button property to render other text
but the original text of the button when the loading state completes.

<div class="bs-example">
    {{bs-button type="primary" data-loading-text="Loading..." data-completed-text="Completed!" loading=loadingState1 title="Submit!" clicked="startLoading1"}}
</div>

``` javascript
startLoading1: function() {
    var _this = this;
    this.set('loadingState', 'loading');
    return Ember.run.later(function() {
      return _this.set('loadingState', 'completed');
    }, 2000);
}
```

Pay attention that this time the `loadingState` is set to `completed` and not `null`.



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
                <td>type</td>
                <td>Alert types: _success_ | _info_ | _warning_ | _danger_</td>
            </tr>
            <tr>
                <td>title</td>
                <td>A string representing the text of the button (_not required if component is used as a block component_)</td>
            </tr>
            <tr>
                <td>clicked</td>
                <td>Triggers the specified function name on the <strong>controller</strong> immediately when the button is clicked.</td>
            </tr>
            <tr>
                <td>clickedParam</td>
                <td>A parameter to pass the action to be invoked immediately when the button is clicked</td>
            </tr>
            <tr>
                <td>size</td>
                <td>Can be: _xs_ | _sm_ | _lg_</td>
            </tr>
            <tr>
                <td>xs</td>
                <td>If set to _true_ it is equivalent to `size=xs`</td>
            </tr>
            <tr>
                <td>small</td>
                <td>If set to _true_ it is equivalent to `size=small`</td>
            </tr>
            <tr>
                <td>large</td>
                <td>If set to _true_ it is equivalent to `size=large`</td>
            </tr>
            <tr>
                <td>block</td>
                <td>If _true_ the button is a block level and will span the full width of its parent</td>
            </tr>
            <tr>
                <td>disabled</td>
                <td>If _true_ the button will be disabled, can also be bound to a _controller_ property</td>
            </tr>
            <tr>
                <td>loading</td>
                <td>Bound to a controller property that defines the state of the button.</td>
            </tr>
            <tr>
                <td>data-loading-text</td>
                <td>If `loading=foo` and `foo` is a property in the _controller_ and `foo` property returns `loading`, then the text of the button will be changed to the value of _this_ property.</td>
            </tr>
            <tr>
                <td>data-xxx-text</td>
                <td>If `loading=foo` and `foo` is a property in the _controller_ and `foo` property returns `xxx`, then the text of the button will be changed to the value of _this_ property.</td>
            </tr>
        </tbody>
    </table>
</div>
