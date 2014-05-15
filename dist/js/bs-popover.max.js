(function() {
  var popoverTemplate, template, tooltipTemplate;

  popoverTemplate = '' + '<div class="arrow"></div>' + '{{#if title}}<h3 class="popover-title">{{title}}</h3>{{/if}}' + '<div class="popover-content">' + '{{#if template}}' + '   {{partial partialTemplateName}}' + '{{else}}' + '   {{#if content}}' + '       {{#if html}}' + '           {{{content}}}' + '       {{else}}' + '           {{content}}' + '       {{/if}}' + '   {{else}}' + '       {{yield}}' + '   {{/if}}' + '{{/if}}' + '    </div>';

  Ember.TEMPLATES["components/bs-popover"] = Ember.Handlebars.compile(popoverTemplate);

  tooltipTemplate = '' + '<div class="tooltip-arrow"></div>' + '<div class="tooltip-inner">' + '{{#if html}}' + '   {{{content}}}' + '{{else}}' + '   {{content}}' + '{{/if}}' + '</div>';

  Ember.TEMPLATES["components/bs-tooltip"] = Ember.Handlebars.compile(tooltipTemplate);

  Bootstrap.BsPopoverComponent = Ember.Component.extend({
    layoutName: 'components/bs-popover',
    classNames: "popover",
    classNameBindings: ["fade", "in", "top", "left", "right", "bottom"],
    top: (function() {
      return this.get("realPlacement") === "top";
    }).property("realPlacement"),
    left: (function() {
      return this.get("realPlacement") === "left";
    }).property("realPlacement"),
    right: (function() {
      return this.get("realPlacement") === "right";
    }).property("realPlacement"),
    bottom: (function() {
      return this.get("realPlacement") === "bottom";
    }).property("realPlacement"),
    titleBinding: "data.title",
    content: Ember.computed.alias('data.content'),
    html: false,
    delay: 0,
    animation: true,
    fade: (function() {
      return this.get("animation");
    }).property("animation"),
    "in": (function() {
      return this.get("isVisible");
    }).property("isVisible"),
    placement: (function() {
      return this.get("data.placement") || "top";
    }).property("data.placement"),
    $element: null,
    $tip: null,
    inserted: false,
    styleUpdater: (function() {
      var actualHeight, actualWidth, calculatedOffset, placement, pos;
      if (!this.$tip || !this.get("isVisible")) {
        return;
      }
      this.$tip.css({
        top: 0,
        left: 0,
        display: "block"
      }).addClass(this.get("realPlacement"));
      placement = this.get("realPlacement");
      pos = this.getPosition();
      actualWidth = this.$tip[0].offsetWidth;
      actualHeight = this.$tip[0].offsetHeight;
      calculatedOffset = this.getCalculatedOffset(placement, pos, actualWidth, actualHeight);
      this.$tip.css("top", calculatedOffset.top);
      this.$tip.css("left", calculatedOffset.left);
      if (this.firstTime) {
        this.firstTime = false;
        this.styleUpdater();
        return this.firstTime = true;
      }
    }).observes("content", "realPlacement", "inserted", "isVisible"),
    init: function() {
      var name, tpl;
      this._super();
      this.set("html", this.get("data.html") || false);
      this.set("template", this.get("data.template") !== undefined);
      if (this.get("template")) {
        name = "components/bs-popover/_partial-content-" + this.get("tip_id");
        tpl = this.get("data.template");
        if (typeof tpl === "function") {
          Ember.TEMPLATES[name] = tpl;
        } else {
          Ember.TEMPLATES[name] = Ember.Handlebars.compile(tpl);
        }
        return this.set("partialTemplateName", name);
      }
    },
    didInsertElement: function() {
      var name,
        _this = this;
      this.$tip = this.$();
      name = Bootstrap.TooltipBoxManager.attribute;
      name = "[" + name + "='" + this.get("tip_id") + "']";
      this.$element = $(name);
      this.set("inserted", true);
      if (this.get("data.trigger") === "hover" && this.get("data.sticky")) {
        this.$().on("mouseenter", function() {
          return clearTimeout(Bootstrap.TooltipBoxManager.timeout);
        });
      }
      this.$().on("mouseleave", function() {
        return Bootstrap.TooltipBoxManager.removeTip(_this.get("tip_id"));
      });
      return this.$().find("img").load(function() {
        return _this.afterRender();
      });
    },
    afterRender: function() {
      return this.notifyPropertyChange("content");
    },
    realPlacement: (function() {
      var $parent, actualHeight, actualWidth, autoPlace, autoToken, docScroll, orgPlacement, parentHeight, parentLeft, parentWidth, placement, pos;
      if (!this.$tip) {
        return null;
      }
      placement = this.get("placement") || "";
      autoToken = /\s?auto?\s?/i;
      autoPlace = autoToken.test(placement);
      if (autoPlace) {
        placement = placement.replace(autoToken, "") || "top";
      }
      pos = this.getPosition();
      actualWidth = this.$tip[0].offsetWidth;
      actualHeight = this.$tip[0].offsetHeight;
      if (autoPlace) {
        $parent = this.$element.parent();
        orgPlacement = placement;
        docScroll = document.documentElement.scrollTop || document.body.scrollTop;
        parentWidth = window.innerWidth;
        parentHeight = window.innerHeight;
        parentLeft = 0;
        placement = (placement === "bottom" && pos.top + pos.height + actualHeight - docScroll > parentHeight ? "top" : (placement === "top" && pos.top - docScroll - actualHeight < 0 ? "bottom" : (placement === "right" && pos.right + actualWidth > parentWidth ? "left" : (placement === "left" && pos.left - actualWidth < parentLeft ? "right" : placement))));
      }
      return placement;
    }).property("placement", "inserted"),
    hasContent: function() {
      return this.get("title");
    },
    getPosition: function() {
      var el;
      el = this.$element[0];
      return $.extend({}, (typeof el.getBoundingClientRect === "function" ? el.getBoundingClientRect() : {
        width: el.offsetWidth,
        height: el.offsetHeight
      }), this.$element.offset());
    },
    getCalculatedOffset: function(placement, pos, actualWidth, actualHeight) {
      if (placement === "bottom") {
        return {
          top: pos.top + pos.height,
          left: pos.left + pos.width / 2 - actualWidth / 2
        };
      } else if (placement === "top") {
        return {
          top: pos.top - actualHeight,
          left: pos.left + pos.width / 2 - actualWidth / 2
        };
      } else if (placement === "left") {
        return {
          top: pos.top + pos.height / 2 - actualHeight / 2,
          left: pos.left - actualWidth
        };
      } else {
        return {
          top: pos.top + pos.height / 2 - actualHeight / 2,
          left: pos.left + pos.width
        };
      }
    },
    actions: {
      close: function() {
        return Bootstrap.TooltipBoxManager.removeTip(this.get("tip_id"));
      }
    }
  });

  Ember.Handlebars.helper('bs-popover', Bootstrap.BsPopoverComponent);

  Bootstrap.BsTooltipComponent = Bootstrap.BsPopoverComponent.extend({
    classNames: "tooltip",
    layoutName: 'components/bs-tooltip',
    init: function() {
      this._super();
      this.classNames.removeObject("popover");
      return this.set("content", this.get("content") || this.get("title"));
    }
  });

  Ember.Handlebars.helper('bs-tooltip', Bootstrap.BsTooltipComponent);

  /*
  The tooltipBox controller is used to render the popovers into the named outlet "bs-tooltip-box"
  with the template tooltip-box
  */


  Bootstrap.TooltipBoxController = Ember.Controller.extend({
    popoversBinding: "Bootstrap.TooltipBoxManager.popovers",
    tooltipsBinding: "Bootstrap.TooltipBoxManager.tooltips"
  });

  template = "" + "{{#each pop in popovers}}" + "   {{bs-popover" + "       tip_id=pop.tip_id" + "       data=pop.data" + "   }}" + "{{/each}}" + "{{#each pop in tooltips}}" + "   {{bs-tooltip" + "       tip_id=pop.tip_id" + "       data=pop.data" + "   }}" + "{{/each}}";

  Ember.TEMPLATES["bs-tooltip-box"] = Ember.Handlebars.compile(template);

  /*
  The Manager is based on the code from the emberjs action helper.
  the tooltip/popover helper sets the attribute TooltipBoxManager.attribute (currently: bootstrap-tip-id)
  with an id that will be increased with each tip.
  AfterRender the manager binds a function to each element containing the attribute "bootstrap-tip-id"
  and on "willClearRender" it will be removed
  */


  Bootstrap.TooltipBoxManager = Ember.Object.create({
    uuid: 0,
    attribute: "bootstrap-tip-id",
    willSetup: false,
    registeredTips: {},
    registerTip: function(type, object, options) {
      var id, self;
      id = ++this.uuid;
      self = this;
      this.registeredTips[id] = {
        id: id,
        data: object,
        eventName: object.trigger || (type === "popover" ? "click" : "hover"),
        bound: false,
        type: type,
        sticky: object.sticky,
        show: function() {
          self.showTip(id);
        },
        hide: function() {
          self.hideTip(id, true);
        },
        toggle: function() {
          self.toggleTip(id);
        }
      };
      if (!this.willSetup) {
        this.willSetup = true;
        Ember.run.scheduleOnce("afterRender", this, function() {
          self.setupBindings();
        });
      }
      options.data.view.on("willClearRender", function() {
        Bootstrap.TooltipBoxManager.removeTip(id);
        $("[" + self.attribute + "='" + id + "']").unbind();
        delete Bootstrap.TooltipBoxManager.registeredTips[id];
      });
      return id;
    },
    setupBindings: function() {
      var elem, i, pop;
      for (i in this.registeredTips) {
        pop = this.registeredTips[i];
        if (pop.bound === false) {
          pop.bound = true;
          elem = $("[" + this.attribute + "='" + i + "']");
          switch (pop.eventName) {
            case "click":
              elem.on("click", $.proxy(pop.toggle, pop));
              break;
            case "hover":
              elem.on("mouseenter", $.proxy(pop.show, pop));
              elem.on("mouseleave", $.proxy(pop.hide, pop));
              break;
            case "focus":
              elem.on("focusin", $.proxy(pop.show, pop));
              elem.on("focusout", $.proxy(pop.hide, pop));
              break;
            case "manual":
              pop.data.addObserver("show", pop, function(sender, key) {
                var value;
                value = sender.get(key);
                if (value) {
                  this.show();
                } else {
                  this.hide();
                }
              });
              if (pop.data.show) {
                this.show();
              }
          }
        }
      }
      this.willSetup = false;
    },
    popovers: [],
    tooltips: [],
    showing: {},
    timeout: null,
    showTip: function(id) {
      var data, obj, type;
      data = this.registeredTips[id].data;
      type = this.registeredTips[id].type;
      if (!this.showing[id]) {
        this.showing[id] = true;
        obj = Ember.Object.create({
          data: data,
          tip_id: id
        });
        if (type === "tooltip") {
          this.tooltips.pushObject(obj);
        } else {
          this.popovers.pushObject(obj);
        }
      }
    },
    hideTip: function(id, allowTimer) {
      var data;
      if (this.showing[id]) {
        data = this.registeredTips[id].data;
        if (allowTimer && data.sticky) {
          this.timedRemove(id);
        } else {
          this.removeTip(id);
        }
      }
    },
    toggleTip: function(id) {
      if (this.showing[id]) {
        this.hideTip(id);
      } else {
        this.showTip(id);
      }
    },
    timedRemove: function(id) {
      var self;
      self = this;
      this.timeout = setTimeout(function() {
        self.removeTip(id);
      }, 100);
    },
    removeTip: function(id) {
      var pop;
      pop = this.popovers.findProperty("tip_id", id) || this.tooltips.findProperty("tip_id");
      this.popovers.removeObject(pop);
      this.tooltips.removeObject(pop);
      delete this.showing[id];
    },
    addFromView: function(view, type, object) {
      var id, options;
      if (!view.attributeBindings.contains(Bootstrap.TooltipBoxManager.attribute)) {
        console.warn("TooltipBoxManager.addFromView: You need to add \"TooltipBoxManager.attribute\" to the attributeBindings!");
        return;
      }
      options = {
        data: {
          view: view
        }
      };
      id = Bootstrap.TooltipBoxManager.registerTip(type, object, options);
      view.set(Bootstrap.TooltipBoxManager.attribute, id);
    },
    helper: function(path, object, options) {
      var binding, keyword, name, o, p, type, value;
      if ((typeof path === "string") && path !== "") {
        p = path.split(".");
        keyword = p[0];
        o = options.data.keywords[keyword];
        if (o) {
          p.removeAt(0);
          p.insertAt(0, "this");
          p = p.join(".");
          object = o.get(p);
        } else {
          object = this.get(path);
        }
      }
      if (path instanceof Object) {
        object = Ember.Object.create({});
        for (name in path.hash) {
          value = path.hash[name];
          type = options.hashTypes[name];
          if (type === "STRING") {
            object.set(name, value);
          } else if (type === "ID") {
            p = value.split(".");
            keyword = p[0];
            o = options.data.keywords[keyword];
            if (!o) {
              o = this;
            } else {
              p.removeAt(0);
            }
            if (!object._bindings) {
              object._bindings = o;
            }
            p.insertAt(0, "_bindings");
            p = p.join(".");
            object[name] = "";
            binding = Ember.Binding.from(p).to(name);
            binding.connect(object);
          }
        }
      }
      return object;
    }
  });

  Ember.Handlebars.registerHelper("bs-bind-popover", function(path) {
    var id, object, options;
    options = arguments[arguments.length - 1];
    object = this;
    object = Bootstrap.TooltipBoxManager.helper.call(this, path, object, options);
    id = Bootstrap.TooltipBoxManager.registerTip("popover", object, options);
    return new Ember.Handlebars.SafeString(Bootstrap.TooltipBoxManager.attribute + "='" + id + "'");
  });

  Ember.Handlebars.registerHelper("bs-bind-tooltip", function(path) {
    var id, object, options;
    options = arguments[arguments.length - 1];
    object = this;
    object = Bootstrap.TooltipBoxManager.helper.call(this, path, object, options);
    id = Bootstrap.TooltipBoxManager.registerTip("tooltip", object, options);
    return new Ember.Handlebars.SafeString(Bootstrap.TooltipBoxManager.attribute + "='" + id + "'");
  });

}).call(this);
