exports = {}

exports.IrreverisibleMigrationError = () ->
  return Error("Tried to reverse a migration without a down method")
exports.MissingStepMethodError = () ->
  return Error("Missing Up Method")
exports.UnknownConnectionError = (name) ->
  return Error("No such connection: #{name}")

module.exports = exports
