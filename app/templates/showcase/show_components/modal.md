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
    {title: 'Submit', clicked: "submit"},
    {title: 'Cancel', clicked: "cancel", dismiss: 'modal'}
  ],

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
});
```


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
    {title: 'Submit', clicked: "submitManual"},
    {title: 'Cancel', dismiss: 'modal'}
  ],

  submitManual: function() {
    Bootstrap.NM.push('Modal destroyed!', 'success');
    return Bootstrap.ModalManager.close('manualModal');
  },
  createModalProgramatically: function() {
    return Bootstrap.BsModalComponent.build({
      name: 'manualModal',
      title: 'Invite Member',
      #The modal's body content will be set to the templateName's content
      templateName: 'demo-template',
      #NOTE: this is important if you want the context of the modal to be the current component, it's possible to set other controllers too.
      targetObject: this,
      footerButtons: this.manualButtons
    });
  }
});
```