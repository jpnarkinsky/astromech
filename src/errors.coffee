exports = {}

exports.IrreverisibleMigrationError = () ->
  return new Error("Tried to reverse a migration without a down method")
exports.MissingStepMethodError = () ->
  return new Error("Missing Up Method")
exports.UnknownConnectionError = (name) ->
  return new Error("No such connection: #{name}")

module.exports = exports
