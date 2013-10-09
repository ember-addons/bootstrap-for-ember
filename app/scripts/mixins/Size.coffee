Bootstrap = window.Bootstrap
get = Ember.get
set = Ember.set

Bootstrap.SizeSupport = Ember.Mixin.create(
    classTypePrefix: Ember.required(String)
    classNameBindings: ['sizeClass', 'largeSizeClass', 'smallSizeClass', 'extraSmallSizeClass']
    #Size value according to Bootstrap sizes: sm/lg/xs
    size: null
    #possible properties to define component size
    xs: null
    small: null
    large: null


    extraSmallSizeClass: ( ->
        pref = @get 'classTypePrefix'
        if @xs then "#{pref}-xs" else null
    ).property('xs').cacheable()

    smallSizeClass: ( ->
        pref = @get 'classTypePrefix'
        if @small then "#{pref}-sm" else null
    ).property('small').cacheable()

    largeSizeClass: ( ->
        pref = @get 'classTypePrefix'
        if @large then "#{pref}-lg" else null
    ).property('large').cacheable()

    sizeClass: ( ->
        size = @get 'size'
        pref = @get 'classTypePrefix'

        if size then "#{pref}-#{size}" else null
    ).property('size').cacheable()
)
