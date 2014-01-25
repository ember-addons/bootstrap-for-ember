/*
Parent component of a progressbar component
*/


(function() {
  Bootstrap.BsProgressComponent = Ember.Component.extend({
    layoutName: 'components/bs-progress',
    classNames: ['progress'],
    classNameBindings: ['animated:active', 'stripped:progress-striped'],
    progress: null,
    stripped: false,
    animated: false,
    "default": (function() {
      return this.progress;
    }).property('progress')
  });

  Ember.Handlebars.helper('bs-progress', Bootstrap.BsProgressComponent);

}).call(this);

(function() {
  Bootstrap.BsProgressbarComponent = Ember.Component.extend(Bootstrap.TypeSupport, {
    layoutName: 'components/bs-progressbar',
    classNames: ['progress-bar'],
    attributeBindings: ['style', 'role', 'aria-valuemin', 'ariaValueNow:aria-valuenow', 'aria-valuemax'],
    classTypePrefix: 'progress-bar',
    role: 'progressbar',
    'aria-valuemin': 0,
    'aria-valuemax': 100,
    init: function() {
      return this._super();
    },
    style: (function() {
      return "width:" + this.progress + "%;";
    }).property('progress').cacheable(),
    ariaValueNow: (function() {
      return this.progress;
    }).property('progress').cacheable()
  });

  Ember.Handlebars.helper('bs-progressbar', Bootstrap.BsProgressbarComponent);

}).call(this);

this["Ember"] = this["Ember"] || {};
this["Ember"]["TEMPLATES"] = this["Ember"]["TEMPLATES"] || {};

this["Ember"]["TEMPLATES"]["components/bs-progress"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Ember.Handlebars.helpers); data = data || {};
  var stack1, hashTypes, hashContexts, helperMissing=helpers.helperMissing, escapeExpression=this.escapeExpression, self=this;

function program1(depth0,data) {
  
  var buffer = '', stack1, hashContexts, hashTypes, options;
  data.buffer.push("\n    ");
  hashContexts = {'progress': depth0,'type': depth0};
  hashTypes = {'progress': "ID",'type': "ID"};
  options = {hash:{
    'progress': ("progress"),
    'type': ("type")
  },contexts:[],types:[],hashContexts:hashContexts,hashTypes:hashTypes,data:data};
  data.buffer.push(escapeExpression(((stack1 = helpers['bs-progressbar'] || depth0['bs-progressbar']),stack1 ? stack1.call(depth0, options) : helperMissing.call(depth0, "bs-progressbar", options))));
  data.buffer.push("\n");
  return buffer;
  }

function program3(depth0,data) {
  
  var buffer = '', hashTypes, hashContexts;
  data.buffer.push("\n    ");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers._triageMustache.call(depth0, "yield", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("\n");
  return buffer;
  }

  hashTypes = {};
  hashContexts = {};
  stack1 = helpers['if'].call(depth0, "default", {hash:{},inverse:self.program(3, program3, data),fn:self.program(1, program1, data),contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  else { data.buffer.push(''); }
  
});

this["Ember"]["TEMPLATES"]["components/bs-progressbar"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Ember.Handlebars.helpers); data = data || {};
  var buffer = '', hashTypes, hashContexts, escapeExpression=this.escapeExpression;


  data.buffer.push("<span class=\"sr-only\">");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers._triageMustache.call(depth0, "progress", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("% Complete</span>");
  return buffer;
  
});