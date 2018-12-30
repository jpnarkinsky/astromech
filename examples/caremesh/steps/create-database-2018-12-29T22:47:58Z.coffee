class CreateDatabase extends Step
  up: ->
    console.log("Starting up migrating for #{this.name}")
    this.withConnection 'cluster', ->
      console.log("Would migrate up using adapter #{this}")

  down: ->
    console.log("Starting down migration for #{this.name}")
    throw new IrreversibleMigration()
