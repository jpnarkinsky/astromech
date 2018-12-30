errors = require('./errors')
util = require ('./util')
_ = require('lodash')

class Step
  constructor: (stage) ->
    console.log("Instantiating class #{this.name}")
    this._stage = stage
  
  @getter 'name', ->
    return this.constructor.name
  
  down: ->
    throw new errors.IrreversibleStepError()
  
  up: ->
    throw new errors.MissingStepMethodError()

  withConnection: (connectionName) ->
    conn = _.find(this, (i) -> i.name == connectionName)
    return conn if conn
    throw new errors.UnknownConnectionError(connectionName)

module.exports = Step
