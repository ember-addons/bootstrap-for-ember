# Modal

> Modals are streamlined, but flexible, dialog prompts with the minimum required functionality and smart defaults.
<small>by Bootstrap</small>

## Blocked Modal

A rendered modal with header, body, and set of actions in the footer.

<div class="bs-example">
    {{bs-button title="Show Modal" clicked="show"}}
    {{#bs-modal name="myModal" fade=true footerButtonsBinding="myModalButtons" title="My Modal"}}
        <p>Modal content!</p>
    {{/bs-modal}}
</div>

``` html
    \{\{bs-button title="Show Modal" clicked="show"\}\}
    \{\{#bs-modal name="myModal" fade=true footerButtonsBinding="myModalButtons" title="My Modal"\}\}
        <p>Modal content!</p>
    \{\{/bs-modal\}\}
```

_Controller's code_:

``` javascript
Showcase.ShowComponentsModalController = Ember.Controller.extend({
  myModalButtons: [
      Ember.Object.create({title: 'Submit', clicked:"submit"})
      Ember.Object.create({title: 'Cancel', clicked:"cancel", dismiss: 'modal'})
  ],

  actions: {
    //Submit the modal
    submit: function() {
      Bootstrap.NM.push('Successfully submitted modal', 'success');
      return Bootstrap.ModalManager.hide('myModal');
    },

    //Cancel the modal, we don't need to hide the model manually because we set {..., dismiss: 'modal'} on the button meta data
    cancel: function() {
      return Bootstrap.NM.push('Modal was cancelled', 'info');
    },

    //Show the modal
    show: function() {
      return Bootstrap.ModalManager.show('myModal');
    }
  }
});
```
NOTE: The buttons defined in the array object can contain the same attributes as the button component. For example: for a 'danger' button, add "type='danger'" to the object defining the button.


## Confirmation Modal
For a simple confirmation modal, you can simply invoke `Bootstrap.ModalManager.confirm(this);`

<div class="bs-example">
    {{bs-button title="Delete" clicked="confirm"}}
</div>

``` html
\{\{bs-button title="Delete" clicked="confirm"\}\}
```

_Controller's code_:

``` javascript
Showcase.ShowComponentsModalController = Ember.Controller.extend({
    confirm: {
        confirm: {
            Bootstrap.ModalManager.confirm(@);
        },
        //invoked when user press "confirm"
        modalConfirmed: {
            Bootstrap.NM.push('Confirmed!', 'success')
        },
        //invoked when user press "cancel"
        modalCanceled: {
            Bootstrap.NM.push('Cancelled!', 'info')
        }
    }
})
```


The `Bootstrap.ModalManager.confirm` method accept the following parameters:

<div class="table-responsive">
    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th style="width: 150px;">Property</th>
                <th>Description</th>
                <th>Optional?</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>controller</td>
                <td>A reference to the controller that the confirm/cancel actions will be triggered on</td>
                <td>no</td>
            </tr>
            <tr>
                <td>title</td>
                <td>The title of the modal that.</td>
                <td>yes</td>
            </tr>
            <tr>
                <td>message</td>
                <td>The body text of the modal.</td>
                <td>yes</td>
            </tr>
            <tr>
                <td>confirmButtonTitle</td>
                <td>The title of the confirm button</td>
                <td>yes</td>
            </tr>
            <tr>
                <td>cancelButtonTitle</td>
                <td>The title of the cancel button</td>
                <td>yes</td>
            </tr>
        </tbody>
    </table>
</div>


## Programatically Modal Creation

It is also possible to programatically create a modal, this approach is useful if the modal contains a lot of elements and it makes sense to push the modal elements into the DOM programatically and totally destroy the modal when it is closed.


<div class="bs-example">
    {{bs-button title="Create Modal" clicked="createModalProgramatically"}}
</div>

``` html
//we only render a button which will programatically create the modal
\{\{bs-button title="Create Modal" clicked="createModalProgramatically"\}\}
```

_Controller's code_:

``` javascript
Showcase.ShowComponentsModalController = Ember.Controller.extend({
  manualButtons: [
      Ember.Object.create({title: 'Submit', clicked:"submitManual"})
      Ember.Object.create({title: 'Cancel', dismiss: 'modal'})
  ],

  actions: {
    submitManual: function() {
      Bootstrap.NM.push('Modal destroyed!', 'success');
      return Bootstrap.ModalManager.close('manualModal');
    },
    createModalProgramatically: function() {
      //@property {string} The name of the modal, required later to close the modal (see submitManual function above)
      //@property {string} The title of the modal.
      //@property {string} The template name to render within the modal body, a View class may also be specified.
      //@property {array} Array of Button meta data
      //@property {object} The controller instance that instantiate the modal.
      Bootstrap.ModalManager.open('manualModal', 'Hello', 'demo-template', this.manualButtons, this);
    }
  }
});
```
