#Contributed by: patricklx https://github.com/patricklx
popoverTemplate = '' +
    '<div class="arrow"></div>' +
    '{{#if title}}<h3 class="popover-title">{{title}}</h3>{{/if}}' +
    '<div class="popover-content">' +
    '{{#if template}}' +
    '   {{partial partialTemplateName}}' +
    '{{else}}' +
    '   {{#if content}}' +
    '       {{#if html}}' +
    '           {{{content}}}' +
    '       {{else}}'+
    '           {{content}}' +
    '       {{/if}}' +
    '   {{else}}' +
    '       {{yield}}' +
    '   {{/if}}' +
    '{{/if}}' +
    '    </div>'

Ember.TEMPLATES["components/bs-popover"] = Ember.Handlebars.compile(popoverTemplate)

tooltipTemplate = '' +
    '<div class="tooltip-arrow"></div>' +
    '<div class="tooltip-inner">' +
    '{{#if html}}' +
    '   {{{content}}}' +
    '{{else}}' +
    '   {{content}}' +
    '{{/if}}' +
    '</div>'

Ember.TEMPLATES["components/bs-tooltip"] = Ember.Handlebars.compile(tooltipTemplate)

Bootstrap.BsPopoverComponent = Ember.Component.extend(
    layoutName: 'components/bs-popover'
    classNames: "popover"
    classNameBindings: [
        "fade"
        "in"
        "top"
        "left"
        "right"
        "bottom"
    ]

    top: (->
        @get("realPlacement") is "top"
    ).property("realPlacement")

    left: (->
        @get("realPlacement") is "left"
    ).property("realPlacement")

    right: (->
        @get("realPlacement") is "right"
    ).property("realPlacement")

    bottom: (->
        @get("realPlacement") is "bottom"
    ).property("realPlacement")

    titleBinding: "data.title"
    content: Ember.computed.alias('data.content')
    html: false
    delay: 0
    animation: true

    fade: (->
        @get "animation"
    ).property("animation")

    in: (->
        @get "isVisible"
    ).property("isVisible")

    placement: (->
        @get("data.placement") or "top"
    ).property("data.placement")

    $element: null
    $tip: null
    inserted: false

    styleUpdater: (->
        return  if not @$tip or not @get("isVisible")
        @$tip.css(
            top: 0
            left: 0
            display: "block"
        ).addClass @get("realPlacement")
        placement = @get("realPlacement")
        pos = @getPosition()
        actualWidth = @$tip[0].offsetWidth
        actualHeight = @$tip[0].offsetHeight
        calculatedOffset = @getCalculatedOffset(placement, pos, actualWidth, actualHeight)
        @$tip.css "top", calculatedOffset.top
        @$tip.css "left", calculatedOffset.left

        if @firstTime
            @firstTime = false
            @styleUpdater()
            @firstTime = true
    ).observes("content", "realPlacement", "inserted", "isVisible")

    init: ->
        @_super()
        @set "html", @get("data.html") or false
        @set "template", @get("data.template") isnt `undefined`
        if @get("template")
            name = "components/bs-popover/_partial-content-" + @get("tip_id")
            tpl = @get("data.template")
            if typeof tpl is "function"
                Ember.TEMPLATES[name] = tpl
            else
                Ember.TEMPLATES[name] = Ember.Handlebars.compile(tpl)
            @set "partialTemplateName", name

    didInsertElement: ->
        @$tip = @$()
        name = Bootstrap.TooltipBoxManager.attribute
        name = "[" + name + "='" + @get("tip_id") + "']"
        @$element = $(name)
        @set "inserted", true

        if @get("data.trigger") is "hover" and @get("data.sticky")
            @$().on "mouseenter", ->
                clearTimeout Bootstrap.TooltipBoxManager.timeout

        @$().on "mouseleave", =>
            Bootstrap.TooltipBoxManager.removeTip @get("tip_id")

        @$().find("img").load =>
            @afterRender()

    afterRender: ->
        @notifyPropertyChange "content"

    realPlacement: (->
        return null  unless @$tip
        placement = @get("placement") or ""
        autoToken = /\s?auto?\s?/i
        autoPlace = autoToken.test(placement)
        placement = placement.replace(autoToken, "") or "top"  if autoPlace
        pos = @getPosition()
        actualWidth = @$tip[0].offsetWidth
        actualHeight = @$tip[0].offsetHeight

        if autoPlace
            $parent = @$element.parent()
            orgPlacement = placement
            docScroll = document.documentElement.scrollTop or document.body.scrollTop
            parentWidth = window.innerWidth
            parentHeight = window.innerHeight
            parentLeft = 0

            placement = (if placement is "bottom" and pos.top + pos.height + actualHeight - docScroll > parentHeight then "top" else (if placement is "top" and pos.top - docScroll - actualHeight < 0 then "bottom" else (if placement is "right" and pos.right + actualWidth > parentWidth then "left" else (if placement is "left" and pos.left - actualWidth < parentLeft then "right" else placement))))

        return placement
    ).property("placement", "inserted")

    hasContent: ->
        @get "title"

    getPosition: ->
        el = @$element[0]
        $.extend {}, (
            if (typeof el.getBoundingClientRect is "function")
                el.getBoundingClientRect()
            else
                width: el.offsetWidth
                height: el.offsetHeight
        ), @$element.offset()

    getCalculatedOffset: (placement, pos, actualWidth, actualHeight) ->
        if placement is "bottom"
            top: pos.top + pos.height
            left: pos.left + pos.width / 2 - actualWidth / 2
        else if placement is "top"
            top: pos.top - actualHeight
            left: pos.left + pos.width / 2 - actualWidth / 2
        else if placement is "left"
            top: pos.top + pos.height / 2 - actualHeight / 2
            left: pos.left - actualWidth
        else
            top: pos.top + pos.height / 2 - actualHeight / 2 # placement == 'right'
            left: pos.left + pos.width

    actions:
        close: ->
            Bootstrap.TooltipBoxManager.removeTip @get("tip_id")
)

Ember.Handlebars.helper 'bs-popover', Bootstrap.BsPopoverComponent

Bootstrap.BsTooltipComponent = Bootstrap.BsPopoverComponent.extend(
    classNames: "tooltip"
    layoutName: 'components/bs-tooltip'
    init: ->
        @_super()
        @classNames.removeObject "popover"
        @set "content", @get("content") or @get("title")
)

Ember.Handlebars.helper 'bs-tooltip', Bootstrap.BsTooltipComponent












###
The tooltipBox controller is used to render the popovers into the named outlet "bs-tooltip-box"
with the template tooltip-box
###
Bootstrap.TooltipBoxController = Ember.Controller.extend(
  popoversBinding: "Bootstrap.TooltipBoxManager.popovers"
  tooltipsBinding: "Bootstrap.TooltipBoxManager.tooltips"
)

template = "" +
    "{{#each pop in popovers}}" +
    "   {{bs-popover" +
    "       tip_id=pop.tip_id" +
    "       data=pop.data" +
    "   }}" +
    "{{/each}}" +
    "{{#each pop in tooltips}}" +
    "   {{bs-tooltip" +
    "       tip_id=pop.tip_id" +
    "       data=pop.data" +
    "   }}" +
    "{{/each}}"

Ember.TEMPLATES["bs-tooltip-box"] = Ember.Handlebars.compile(template)

###
The Manager is based on the code from the emberjs action helper.
the tooltip/popover helper sets the attribute TooltipBoxManager.attribute (currently: bootstrap-tip-id)
with an id that will be increased with each tip.
AfterRender the manager binds a function to each element containing the attribute "bootstrap-tip-id"
and on "willClearRender" it will be removed
###
Bootstrap.TooltipBoxManager = Ember.Object.create(
  uuid: 0
  attribute: "bootstrap-tip-id"
  willSetup: false
  registeredTips: {}
  registerTip: (type, object, options) ->
    id = ++@uuid
    self = this
    @registeredTips[id] =
      id: id
      data: object
      eventName: object.trigger or ((if type is "popover" then "click" else "hover"))
      bound: false
      type: type
      sticky: object.sticky
      show: ->
        self.showTip id
        return

      hide: ->
        self.hideTip id, true
        return

      toggle: ->
        self.toggleTip id
        return

    unless @willSetup
      @willSetup = true
      Ember.run.scheduleOnce "afterRender", this, ->
        self.setupBindings()
        return

    options.data.view.on "willClearRender", ->
      Bootstrap.TooltipBoxManager.removeTip id
      $("[" + self.attribute + "='" + id + "']").unbind()
      delete Bootstrap.TooltipBoxManager.registeredTips[id]

      return

    id

  setupBindings: ->
    for i of @registeredTips
      pop = @registeredTips[i]
      if pop.bound is false
        pop.bound = true
        elem = $("[" + @attribute + "='" + i + "']")
        switch pop.eventName
          when "click"
            elem.on "click", $.proxy(pop.toggle, pop)
          when "hover"
            elem.on "mouseenter", $.proxy(pop.show, pop)
            elem.on "mouseleave", $.proxy(pop.hide, pop)
          when "focus"
            elem.on "focusin", $.proxy(pop.show, pop)
            elem.on "focusout", $.proxy(pop.hide, pop)
          when "manual"
            pop.data.addObserver "show", pop, (sender, key) ->
              value = sender.get(key)
              if value
                @show()
              else
                @hide()
              return

            @show()  if pop.data.show
    @willSetup = false
    return

  popovers: []
  tooltips: []
  showing: {}
  timeout: null
  showTip: (id) ->
    data = @registeredTips[id].data
    type = @registeredTips[id].type
    unless @showing[id]
      @showing[id] = true
      obj = Ember.Object.create(
        data: data
        tip_id: id
      )
      if type is "tooltip"
        @tooltips.pushObject obj
      else
        @popovers.pushObject obj
    return

  hideTip: (id, allowTimer) ->
    if @showing[id]
      data = @registeredTips[id].data
      if allowTimer and data.sticky
        @timedRemove id
      else
        @removeTip id
    return

  toggleTip: (id) ->
    if @showing[id]
      @hideTip id
    else
      @showTip id
    return

  timedRemove: (id) ->
    self = this
    @timeout = setTimeout(->
      self.removeTip id
      return
    , 100)
    return

  removeTip: (id) ->
    pop = @popovers.findProperty("tip_id", id) or @tooltips.findProperty("tip_id")
    @popovers.removeObject pop
    @tooltips.removeObject pop
    delete @showing[id]

    return

  addFromView: (view, type, object) ->
    unless view.attributeBindings.contains(Bootstrap.TooltipBoxManager.attribute)
      console.warn "TooltipBoxManager.addFromView: You need to add \"TooltipBoxManager.attribute\" to the attributeBindings!"
      return
    options = data:
      view: view

    id = Bootstrap.TooltipBoxManager.registerTip(type, object, options)
    view.set Bootstrap.TooltipBoxManager.attribute, id
    return

  helper: (path, object, options) ->
    #passing an object that has all variables
    if (typeof path is "string") and path isnt ""
      p = path.split(".")
      keyword = p[0]
      o = options.data.keywords[keyword]
      if o
        p.removeAt 0
        p.insertAt 0, "this"
        p = p.join(".")
        object = o.get(p)
      else
        object = @get(path)

    #passing all variables individually
    #strings and variables are supported!!
    if path instanceof Object
      object = Ember.Object.create({})
      for name of path.hash
        value = path.hash[name]
        type = options.hashTypes[name]

        #set string directrly
        if type is "STRING"
          object.set name, value
        else if type is "ID"

          #is variable to which we can bind
          #get context from keywords -> the each helper defines it
          p = value.split(".")
          keyword = p[0]
          o = options.data.keywords[keyword]
          unless o

            #no context in keywords, assuming current context
            o = this
          else
            p.removeAt 0
          object._bindings = o  unless object._bindings
          p.insertAt 0, "_bindings"
          p = p.join(".")
          object[name] = ""
          binding = Ember.Binding.from(p).to(name)
          binding.connect object
    object
)

Ember.Handlebars.registerHelper "bs-bind-popover", (path) ->
    options = arguments[arguments.length - 1]
    object = this
    object = Bootstrap.TooltipBoxManager.helper.call(this, path, object, options)
    id = Bootstrap.TooltipBoxManager.registerTip("popover", object, options)
    new Ember.Handlebars.SafeString(Bootstrap.TooltipBoxManager.attribute + "='" + id + "'")

Ember.Handlebars.registerHelper "bs-bind-tooltip", (path) ->
    options = arguments[arguments.length - 1]
    object = this
    object = Bootstrap.TooltipBoxManager.helper.call(this, path, object, options)
    id = Bootstrap.TooltipBoxManager.registerTip("tooltip", object, options)
    new Ember.Handlebars.SafeString(Bootstrap.TooltipBoxManager.attribute + "='" + id + "'")
