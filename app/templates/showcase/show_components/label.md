# Label

## Basic

<div class="bs-example">
    <h4>Heading with label {{bs-label content="Label"}}</h3>
</div>

``` html
    <h3>Heading with label \{\{bs-label content="Label"\}\}</h3>
```

## With Type

<div class="bs-example">
    <h3>Heading with <strong>danger</strong> {{bs-label content="Careful!" type="danger"}}</h3>
</div>

``` html
    <h3>Heading with <strong>danger</strong> \{\{bs-label content="Careful!" type="danger"\}\}</h3>
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
                <td>content</td>
                <td>string: the label content.</td>
            </tr>
            <tr>
                <td>type</td>
                <td>Label types: success | info | warning | danger</td>
            </tr>
        </tbody>
    </table>
</div>
