Bootstrap.BsTabsPanes = Bootstrap.ItemsPanesView.extend(
    classNames: ['tab-content']
    itemViewClass: Bootstrap.BsTabPane
)

Ember.Handlebars.helper('bs-tabs-panes', Bootstrap.BsTabsPanes)