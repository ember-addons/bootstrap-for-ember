# Tabs in conjuction with Routes

Rendering tab content can be simply done by providing a template per tab using the _bs-tabs-panes_ component,
Another possiblity is to have a _route per tab_ for rendering tabs contents, Choose this approach if:


* **You need your tabs to be bookmarkable, this is possible because each route is bound to some URL path.**
* **Your tabs are complicated and have a lot of logic and you need a controller per tab.**

If one or more of the reasons above makes sense to you, read on, otherwise use _bs-tabs-panes_ because its setup is much simpler.

## Users Profile Example

This is much easier to explain by example, so for the sake of example, we'll build a User profile with 3 tabs.

## Defining routes

First, lets define the routes of the User profile:

``` javascript
this.resource('user', function() {
  this.route('general');
  this.route('privacy');
  return this.route('activities');
});
```

A resource is required per tabs component, here we define the resource as _user_ because tabs deals with managing a _User_ and a _@route_ is required per tab.


## Putting the Tabs component in the Resource template.

In Ember.js, every resource page has its own main template, nested routes are rendered within the _resource_ page, with such hierarchy, it makes sense to put the _tabs component_ in the resource page so it will be available for any nested route that the user visits.

Content goes into the `user` template.

``` html
    \{\{bs-tabs contentBinding="tabsMeta"\}\}
    \{\{outlet\}\}
```

The `tabsMeta` is an array of the Tabs metadata in the `UserController`:

``` javascript

App.UserController = Ember.Controller.extend({
  tabsMeta: [
    Ember.Object.create({title: 'General', linkTo: 'user.general'}),
    Ember.Object.create({title: 'Privacy', linkTo: 'user.privacy'}),
    Ember.Object.create({title: 'Activities', linkTo: 'user.activities'})
  ]
});
````

The _outlet_ is important so the content of each tab will be rendered beneath the tabs component.


## Defining Templates

Simply define a template per nested route, just like you would do if each nested route wouldnt be apart of the tab component.

## Live example

Want to see it alive? take a look here: {{#link-to "user.general"}}User Profile{{/link-to}}
