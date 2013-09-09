/*
Modal component.
*/


(function() {
  Bootstrap.BsModalComponent = Ember.Component.extend({
    classNames: ['modal'],
    attributeBindings: ['role', 'aria-labelledby', 'isAriaHidden:aria-hidden', "ariaLabelledBy:aria-labelledby"],
    isAriaHidden: (function() {
      return "" + (this.get('isVisible'));
    }).property('isVisible'),
    modalBackdrop: '<div class="modal-backdrop fade in"></div>',
    role: 'dialog',
    backdrop: true,
    title: null,
    isVisible: false,
    manual: false,
    didInsertElement: function() {
      var name;
      this._super();
      this.setupBinders();
      name = this.get('name');
      Ember.assert("Modal name is required for modal view " + (this.get('elementId')), this.get('name'));
      if (name == null) {
        name = this.get('elementId');
      }
      Bootstrap.ModalManager.add(name, this);
      if (this.manual) {
        return this.show();
      }
    },
    becameVisible: function() {
      if (this.get("backdrop")) {
        return this.appendBackdrop();
      }
    },
    becameHidden: function() {
      if (this._backdrop) {
        return this._backdrop.remove();
      }
    },
    appendBackdrop: function() {
      var parentElement;
      parentElement = this.$().parent();
      return this._backdrop = Em.$(this.modalBackdrop).appendTo(parentElement);
    },
    show: function() {
      return this.set('isVisible', true);
    },
    hide: function() {
      return this.set('isVisible', false);
    },
    toggle: function() {
      return this.get('isVisible').toggleProperty();
    },
    click: function(event) {
      var target, targetDismiss;
      target = event.target;
      targetDismiss = target.getAttribute("data-dismiss");
      if (targetDismiss === 'modal') {
        return this.close();
      }
    },
    keyPressed: function(event) {
      if (event.keyCode === 27) {
        return this.close(event);
      }
    },
    close: function(event) {
      if (this.get('manual')) {
        return this.destroy();
      } else {
        return this.hide();
      }
    },
    willDestroyElement: function() {
      var name;
      this.removeHandlers();
      name = this.get('name');
      if (name == null) {
        name = this.get('elementId');
      }
      Bootstrap.ModalManager.remove(name, this);
      if (this._backdrop) {
        return this._backdrop.remove();
      }
    },
    removeHandlers: function() {
      return jQuery(window.document).unbind("keyup", this._keyUpHandler);
    },
    setupBinders: function() {
      var handler,
        _this = this;
      handler = function(event) {
        return _this.keyPressed(event);
      };
      jQuery(window.document).bind("keyup", handler);
      return this._keyUpHandler = handler;
    }
  });

  Bootstrap.BsModalComponent = Bootstrap.BsModalComponent.reopenClass({
    build: function(options) {
      var modalPane;
      if (!options) {
        options = {};
      }
      options.manual = true;
      modalPane = this.create(options);
      return modalPane.append();
    }
  });

  Bootstrap.ModalManager = Ember.Object.create({
    add: function(name, modalView) {
      return this.set(name, modalView);
    },
    remove: function(name) {
      return this.set(name, null);
    },
    close: function(name) {
      return this.get(name).close();
    },
    hide: function(name) {
      return this.get(name).hide();
    },
    show: function(name) {
      return this.get(name).show();
    }
  });

}).call(this);

this["Ember"] = this["Ember"] || {};
this["Ember"]["TEMPLATES"] = this["Ember"]["TEMPLATES"] || {};

this["Ember"]["TEMPLATES"]["components/bs-modal"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Ember.Handlebars.helpers); data = data || {};
  var buffer = '', stack1, hashTypes, hashContexts, escapeExpression=this.escapeExpression, helperMissing=helpers.helperMissing, self=this;

function program1(depth0,data) {
  
  var buffer = '', hashTypes, hashContexts;
  data.buffer.push("\n                ");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers.view.call(depth0, "view.body", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("\n            ");
  return buffer;
  }

function program3(depth0,data) {
  
  var buffer = '', hashTypes, hashContexts;
  data.buffer.push("\n                ");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers._triageMustache.call(depth0, "yield", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("\n            ");
  return buffer;
  }

function program5(depth0,data) {
  
  var buffer = '', stack1, hashContexts, hashTypes, options;
  data.buffer.push("\n                ");
  hashContexts = {'content': depth0,'targetObjectBinding': depth0};
  hashTypes = {'content': "ID",'targetObjectBinding': "STRING"};
  options = {hash:{
    'content': (""),
    'targetObjectBinding': ("view.targetObject")
  },contexts:[],types:[],hashContexts:hashContexts,hashTypes:hashTypes,data:data};
  data.buffer.push(escapeExpression(((stack1 = helpers['bs-button'] || depth0['bs-button']),stack1 ? stack1.call(depth0, options) : helperMissing.call(depth0, "bs-button", options))));
  data.buffer.push("\n            ");
  return buffer;
  }

  data.buffer.push("<div class=\"modal-dialog\">\n    <div class=\"modal-content\">\n        <div class=\"modal-header\">\n            <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">&times;</button>\n            <h4 class=\"modal-title\">");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers._triageMustache.call(depth0, "title", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("</h4>\n        </div>\n        <div class=\"modal-body\">\n            ");
  hashTypes = {};
  hashContexts = {};
  stack1 = helpers['if'].call(depth0, "body", {hash:{},inverse:self.program(3, program3, data),fn:self.program(1, program1, data),contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("\n        </div>\n        <div class=\"modal-footer\">\n            ");
  hashTypes = {};
  hashContexts = {};
  stack1 = helpers.each.call(depth0, "footerButtons", {hash:{},inverse:self.noop,fn:self.program(5, program5, data),contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("\n        </div>\n    </div>\n</div>");
  return buffer;
  
});