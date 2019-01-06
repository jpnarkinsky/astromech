Inflector = require('inflected')
util = require ('./util')
_ = require('lodash')

class Iteration
  constructor: () ->
  
  @getter 'name', -> this.constructor.name
  @getter 'title', -> Inflector.titleize(this.name)

  down: ->
    throw new Error("Method 'down' not implemented for iteration #{this.name}")
  
  up: ->
    throw new Error("Method 'up' not implemented for iteration #{this.name}")

  withService: (serviceName) ->
    svc = _.find(this.services, (i) -> i.name == services)
    return svc if svc
    throw new Error("No such service #{serviceName} for iteration #{this.name}")

module.exports = Iteration
