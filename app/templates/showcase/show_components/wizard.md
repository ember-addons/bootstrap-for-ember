# Wizard

Wizard is a multi step view component with transitioning workflow,
Wizard has a lot in common with the Tabs component as you can think about each Wizard step as a tab & pane, the main different is that with the Wizard component the transitioning order of the steps is defined a head.

## Wizard Sample

Defining an inline content Wizard with blocks is the simplest form of using the wizard component.

<div class="bs-example">
    {{bs-wizard contentBinding="steps"}}
</div>


``` html
\{\{bs-wizard contentBinding="steps"\}\}
```

`contentBinding="steps"` defines a property named _steps_ in the current controll that defines the wizard steps,
Here is the current controll of this example:

``` javascript
Showcase.ShowComponentsWizardController = Ember.Controller.extend({
  init: function() {
    this._super();
    this.set('steps', Ember.A([
      Ember.Object.create({title: 'Foo', template: 'tabs/foo-tabpane'}),
      Ember.Object.create({title: 'Bar', template: 'tabs/bar-tabpane'}),
      Ember.Object.create({title: 'Baz', template: 'tabs/baz-tabpane'})
    ]));
  }
});
```

## Disable Step Selection

Sometimes it makes sense to create a wizard with fixed step flow, this can be done by disabling the steps by providing `disabled=true` per step.

It is also possible to disallow moving to previous step if needed.

<div class="bs-example">
    {{bs-wizard prevAllowed=false contentBinding="stepsNoPrev"}}
</div>

``` html
\{\{bs-wizard prevAllowed=false contentBinding="stepsNoPrev"\}\}
```

``` javascript
Showcase.ShowComponentsWizardController = Ember.Controller.extend({
  init: function() {
    this._super();
    this.set('steps', Ember.A([
      Ember.Object.create({title: 'Step1', template: 'tabs/foo-tabpane', disabled="true"}),
      Ember.Object.create({title: 'Step2', template: 'tabs/bar-tabpane', disabled="true"}),
      Ember.Object.create({title: 'Step3', template: 'tabs/baz-tabpane', disabled="true"})
    ]));
  }
});
```

## Programatically Created Wizard

Creating a wizard programatically should be used if rendering a Wizard is based on some action such as a button click, for example, a modal can be rendered by pressing a button that will render a Wizard within a modal as the example shown below:

<div class="bs-example">
    {{bs-button title="Start Wizard" type="primary" clicked="createWizard"}}
</div>


``` html
\{\{bs-button title="Start Wizard" type="primary" clicked="createWizard"\}\}
```

_Controller's code:_

``` javascript
Showcase.ShowComponentsWizardController = Ember.Controller.extend({
  actions: {
    createWizard: function() {
      var body;
      body = Bootstrap.BsWizardComponent.extend({
        content: [
          Ember.Object.create({title: 'Step1', template: 'wizard/step1', disabled: true}),
          Ember.Object.create({title: 'Step2', template: 'wizard/step2', disabled: true}),
          Ember.Object.create({title: 'Step3', template: 'wizard/step3', disabled: true})
        ],
        targetObject: this,
        onNext: "onNext",
        onPrev: "onPrev",
        onFinish: 'onFinish'
      });
      Bootstrap.ModalManager.open('manualModal', 'Wizard Title...', body, null, this);
    },
    onNext: function() {
      return console.log('NEXT');
    },
    onPrev: function() {
      return console.log('PREV');
    },
    onFinish: function() {
      Bootstrap.ModalManager.close('manualModal');
      return Bootstrap.NM.push('Wizard completed!');
    }
  }
});
```

The controller is responsible for creating the Modal and the Wizard components, our controller listens to the Wizard _onFinish_ event and close the modal as a response plus send an application notification.