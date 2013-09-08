# Alert

## Usage Examples

<div class="bs-example">
    {{bs-alert message="A warning alert with simple message." type="warning"}}
</div>

```html
\{\{bs-alert message="A warning alert with simple message." type="warning"\}\}
```

<div class="bs-example">
    {{bs-alert message="With close button" type="warning" dismiss=true}}
</div>

```html
\{\{bs-alert message="With close button" type="warning" dismiss=true\}\}
```

<div class="bs-example">
    {{bs-alert message="Close button will fade" type="warning" dismiss=true fade=true}}
</div>

```html
    \{\{bs-alert message="Close button will fade" type="warning" dismiss=true fade=true\}\}
```

<div class="bs-example">
    {{bs-alert message="Dismissed after 5 seconds!!" type="info" fade=true dismissAfter=5}}
</div>

```html
    \{\{bs-alert message="Dismissed after 5 seconds" type="info" dismissAfter=5\}\}
```

<div class="bs-example">
    {{bs-alert message="Other types such as Sucess" type="success"}}
</div>

```html
    \{\{bs-alert message="Other types such as Sucess" type="success"\}\}
```

<div class="bs-example">
    {{#bs-alert type="danger"}}
    <h4 class="alert-heading">Oh snap! You got an error!</h4>
    <p>Alert can also be used in a <strong>block form</strong>.</p>
    <p>
        <button class="btn btn-danger" {{action "submit"}}>Take this action</button> <a class="btn btn-default">Or do this</a>
    </p>
    {{/bs-alert}}
</div>

```html
\{\{#bs-alert type="danger"\}\}
<h4 class="alert-heading">Oh snap! You got an error!</h4>
<p>Alert can also be used in a <strong>block form</strong>.</p>
<p>
<button class="btn btn-danger" \{\{action "submit"\}\}>Take this action</button> <a class="btn btn-default">Or do this</a>
</p>
\{\{/bs-alert\}\}
```

<div class="bs-example">
    {{bs-alert message="Close will trigger a function in controller" type="warning" dismiss=true closed="didAlertClosed" close="didAlertClose"}}
</div>

``` html
    \{\{bs-alert message="Close will trigger a function in controller" type="warning" dismiss=true closed="didAlertClosed" close="didAlertClose"\}\}
```

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
                <td>message</td>
                <td>The string to display in the alert.</td>
            </tr>
            <tr>
                <td>type</td>
                <td>Alert types: success | info | warning | danger</td>
            </tr>
            <tr>
                <td>dismiss</td>
                <td>if true an <code>X</code> link is set to dismiss the alert.</td>
            </tr>
            <tr>
                <td>dismissAfter</td>
                <td>If set the alert will be automatically dismissed after the specified amount of <code>seconds</code></td>
            </tr>
            <tr>
                <td>fade</td>
                <td>If true, the dialog will be faded out when closed.</td>
            </tr>
            <tr>
                <td>close</td>
                <td>Triggers the specified function name on the <strong>controller</strong> immediately when the close instance method is called.</td>
            </tr>
            <tr>
                <td>closed</td>
                <td>Triggers the specified function name on the <strong>controller</strong> when the alert has been closed (will wait for CSS transitions to complete).</td>
            </tr>
        </tbody>
    </table>
</div>

