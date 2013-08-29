###
A Mixin that provides the basic configuration for rendering and interacting with Bootstrap navigation item such a pill or a tab.
###
Bootstrap.NavItem = Ember.Mixin.create(Bootstrap.SelectableView
    #unncessary as Ember magically matches this according to the parent collectionView tag
    #tagName: 'li'
)