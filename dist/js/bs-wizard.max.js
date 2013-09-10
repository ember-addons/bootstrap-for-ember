(function() {
  Bootstrap.BsWizardStep = Bootstrap.ItemView.extend(Bootstrap.ItemSelection, Bootstrap.NavItem, {
    classNames: ['wizard-step'],
    classNameBindings: ['completed'],
    completed: false,
    template: Ember.Handlebars.compile(['{{view view.stepAsLink}}'].join("\n")),
    stepAsLink: Ember.View.extend({
      tagName: 'a',
      template: Ember.Handlebars.compile('{{view.parentView.title}}'),
      attributeBindings: ['href'],
      href: "#"
    })
  });

  Bootstrap.BsWizardSteps = Bootstrap.ItemsView.extend(Bootstrap.Nav, {
    navType: 'pills',
    classNames: ['wizard-steps'],
    itemViewClass: Bootstrap.BsWizardStep,
    currentItemIdx: (function() {
      var i, selected, selectedItem, view, _i, _len, _ref;
      selected = this.get('selected');
      i = 0;
      _ref = this._childViews;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        view = _ref[_i];
        if (view.get('content') === selected) {
          selectedItem = view;
          break;
        }
        i++;
      }
      if (selectedItem) {
        return i;
      } else {
        return null;
      }
    }).property('selected')
  });

  Bootstrap.BsWizardStepPane = Bootstrap.ItemPaneView.extend();

  Bootstrap.BsWizardStepsPanes = Bootstrap.ItemsPanesView.extend({
    classNames: ['wizard-panes'],
    itemViewClass: Bootstrap.BsWizardStepPane
  });

  Bootstrap.BsWizardComponent = Ember.ContainerView.extend(Ember.TargetActionSupport, {
    classNames: ['wizard'],
    childViews: ['steps', 'panes', 'controls'],
    prevAllowed: true,
    items: (function() {
      var _ref;
      return (_ref = this._childViews) != null ? _ref[0] : void 0;
    }).property('content'),
    panes: (function() {
      return this._childViews[1];
    }).property('content'),
    steps: Bootstrap.BsWizardSteps.extend({
      contentBinding: 'parentView.content',
      selectedBinding: 'parentView.selected'
    }),
    panes: Bootstrap.BsWizardStepsPanes.extend({
      contentBinding: 'parentView.content'
    }),
    controls: Ember.ContainerView.extend({
      childViews: ['prev', 'next', 'finish'],
      prev: Bootstrap.BsButtonComponent.extend({
        layoutName: 'components/bs-button',
        title: 'Prev',
        size: 'xs',
        "data-rel": 'PREV',
        isVisible: (function() {
          return this.get('parentView').get('parentView').get('hasPrev');
        }).property('parentView.parentView.items.selected')
      }),
      next: Bootstrap.BsButtonComponent.extend({
        layoutName: 'components/bs-button',
        title: 'Next',
        size: 'xs',
        "data-rel": 'NEXT',
        isVisible: (function() {
          return this.get('parentView').get('parentView').get('hasNext');
        }).property('parentView.parentView.items.selected')
      }),
      finish: Bootstrap.BsButtonComponent.extend({
        layoutName: 'components/bs-button',
        title: 'Finish',
        size: 'xs',
        "data-rel": 'FINISH',
        isVisible: (function() {
          return this.get('parentView').get('parentView').get('isLast');
        }).property('parentView.parentView.items.selected')
      })
    }),
    currentStepIdx: (function() {
      return this.get('items').get('currentItemIdx');
    }).property('items.selected'),
    willInsertElement: function() {
      this.get('panes').set('items-id', this.get('items').get('elementId'));
      return this.get('items').set('default', this.get('items')._childViews[0].get('content').get('title'));
    },
    click: function(event) {
      var b;
      b = event.target.getAttribute("data-rel");
      if (b === 'PREV') {
        this.prev();
      }
      if (b === 'NEXT') {
        this.next();
      }
      if (b === 'FINISH') {
        return this.close();
      }
    },
    next: function() {
      var currIdx;
      if (this.get('hasNext')) {
        this.stepCompleted(this.get('currentStepIdx'));
        currIdx = this.get('currentStepIdx') + 1;
        this.move(currIdx);
        return this.triggerAction({
          action: 'onNext',
          actionContext: this.get('targetObject')
        });
      }
    },
    prev: function() {
      var currIdx;
      if (this.get('hasPrev')) {
        currIdx = this.get('currentStepIdx') - 1;
        this.stepCompleted(currIdx, false);
        this.move(currIdx);
        return this.triggerAction({
          action: 'onPrev',
          actionContext: this.get('targetObject')
        });
      }
    },
    move: function(idx) {
      var _ref, _ref1;
      return (_ref = this._childViews[0]) != null ? _ref.set('selected', (_ref1 = this._childViews[0]._childViews[idx]) != null ? _ref1.get('content') : void 0) : void 0;
    },
    hasNext: (function() {
      return this.get('items')._childViews.length > this.get('currentStepIdx') + 1;
    }).property('currentStepIdx'),
    hasPrev: (function() {
      this.get('currentStepIdx') > 0;
      return this.get('currentStepIdx') > 0 && this.get('prevAllowed');
    }).property('currentStepIdx'),
    isLast: (function() {
      return this.get('items')._childViews.length === this.get('currentStepIdx') + 1;
    }).property('currentStepIdx'),
    close: (function() {
      this.triggerAction({
        action: 'onFinish',
        actionContext: this.get('targetObject')
      });
      return this.destroy();
    }),
    stepCompleted: function(idx, compl) {
      if (compl == null) {
        compl = true;
      }
      return this._childViews[0]._childViews[idx].set('completed', compl);
    }
  });

  Bootstrap.BsWizardComponent = Bootstrap.BsWizardComponent.reopenClass({
    build: function(options) {
      var wizard;
      if (!options) {
        options = {};
      }
      options.manual = true;
      wizard = this.create(options);
      return wizard.append();
    }
  });

  Ember.Handlebars.helper('bs-wizard', Bootstrap.BsWizardComponent);

}).call(this);
