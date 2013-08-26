# Badge

<div class="bs-example">
    <a href="#"> Inbox {{bs-badge content="42"}} </a>
</div>

``` html
<a href="#"> Inbox\{\{bs-badge content="42"\}\} </a>
```

## Built-in styles

Works well with built-in styles that are included for placing badges in active states in pill and list navigations.

<div class="bs-example">
    <ul class="nav nav-pills">
        <li class="active"><a href="#">Home {{bs-badge content=42}}</a></li>
        <li><a href="#">Profile</a></li>
        <li><a href="#">Messages {{bs-badge content=3}}</a></li>
    </ul>
    <br>
    <ul class="nav nav-pills nav-stacked" style="max-width: 260px;">
        <li class="active">
            <a href="#">
                {{bs-badge class="pull-right"content=42}}
                Home
            </a>
        </li>
        <li><a href="#">Profile</a></li>
        <li>
            <a href="#">
                {{bs-badge class="pull-right"content=3}}
                Messages
            </a>
        </li>
    </ul>
</div>

``` html
<ul class="nav nav-pills">
    <li class="active"><a href="#">Home \{\{bs-badge content=42\}\}</a></li>
    <li><a href="#">Profile</a></li>
    <li><a href="#">Messages \{\{bs-badge content=3\}\}</a></li>
</ul>
<br>
<ul class="nav nav-pills nav-stacked" style="max-width: 260px;">
    <li class="active">
        <a href="#">
            \{\{bs-badge class="pull-right"content=42\}\}
            Home
        </a>
    </li>
    <li><a href="#">Profile</a></li>
    <li>
        <a href="#">
            \{\{bs-badge class="pull-right"content=3\}\}
            Messages
        </a>
    </li>
</ul>
```