colors = require('colors')
program = require('commander')
version = require('./version')

program
  .name('astromech')
  .version(version)

program
  .command 'dump [version]'
  .action (version, cmd) ->
    console.log("Would dump objects")

program
  .command 'versions'
  .action (cmd) ->
    console.log("Would output versions")

program.parse process.argv
program.outputHelp colors.red if (process.argv.length < 3)
