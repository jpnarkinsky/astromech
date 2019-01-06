util = require('../util')

class Adapter
  commands: ->
    throw new Error("Method commands not implentned for adapter #{this.name}")

module.exports = Adapter
