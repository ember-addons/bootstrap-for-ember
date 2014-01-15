#Item action bar

When listing items that support selection, it usually make sense to perform some actions on the selected item(s).

The Items action bar component make it possible to build an bar of buttons where each button visibility may behave differently according to the selection,

For example an 'Edit' button may be disabled unless 1 item is selected, or a 'Delete' button may be enabled only
when there is 1 or more items selected.

In the template, only 1 expression is needed, the `content` property is expected to be an array of objects where
each object represents a button in the bar, the `selectedItems` property is expected to be an array of the currently
selected items on a list.

<div class="bs-example">
    {{bs-items-action-bar contentBinding="actionsInBar" selectedItemsBinding="selection"}}
    {{bs-pills contentBinding="items" selectedBinding="selection"}}
</div>

For the sake of simplicity in this example we use the `bs-pills` component to list items with signle itemselection support,
but this can be replaced with a table or any other visual form that supports selection.

``` html
\{\{bs-items-action-bar contentBinding="actionsInBar" selectedItemsBinding="selection"\}\}
\{\{bs-pills contentBinding="items" selectedBinding="selection"\}\}
```

Per action defined in the controller (see below), it is possible to define whether the action should be disabled or not
and what should happen when an enabled action is clicked,

* Implement the `disabled` function per action and return `true` if the action should be disabled, the method recieve the current selection so logic may take the selection into consideration whether the action should be disabled or not.
* Define `transitionTo` property with a route name if you want the action to transition to another route when pressed.
* Define the `clickActionName` property with an action name to be invoked on the controller when action is clicked.


Controller's code:

``` javascript
MyController = Ember.Controller.extend({
    actionsInBar: [
        Ember.Object.create({
          title: 'To Alerts',
          //return true if action should be disabled, this method is invoked whenever the selection is changed.
          disabled: function(selection) {
            var _ref;
            if (selection.size < 1 || (selection != null ? (_ref = selection[0]) != null ? _ref.title : void 0 : void 0) !== 'Alerts') {
              return true;
            }
          },
          //transition to some route if action is clicked
          transitionTo: 'show_components.alert'
        }),
        Ember.Object.create({
          title: 'To Wizard',
          disabled: function(selection) {
            var _ref;
            if (selection.size < 1 || (selection != null ? (_ref = selection[0]) != null ? _ref.title : void 0 : void 0) !== 'Wizards') {
              return true;
            }
          },
          //invoke a controller action when action is clicked
          clickActionName: 'wizard'
         })
        //... more actions goes here
    ],
    actions: {
      wizard: function() {
        return alert("Wizard pressed!");
      }
    },
    items: [
      Ember.Object.create({title: 'Alerts'}),
      Ember.Object.create({title: 'Panels'}),
      Ember.Object.create({title: 'Wizards'})
    ]
  });
})
```