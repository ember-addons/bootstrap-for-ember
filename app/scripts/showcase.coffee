Bootstrap = window.Bootstrap
Showcase = window.Showcase = Ember.Application.create(
    LOG_TRANSITIONS: true
    LOG_VIEW_LOOKUPS: true
    LOG_ACTIVE_GENERATION: true
)

Ember.ENV =
    HELPER_PARAM_LOOKUPS: true

Ember.Handlebars.registerHelper 'raw', (value) ->
    value.fn(value)

require('scripts/showcase/router')
require('scripts/showcase/routes/*')
require('scripts/showcase/controllers/*')