colors = require('colors')
logger = require('./logger')
program = require('commander')
version = require('./version')

# Include commands
init = require('./commands/init')
generate = require('./commands/generate')

program
	.name('astromech')
  .version(version)
  .option('-c, --config <path>', 'Configuration file to load')

program
	.command 'init [dir]'
	.description 'initialize a project'
  .option('-p, --project-name <projectName>', 'Project name to use (defaults to directory name')
	.action init

program
	.command 'iterations'
	.description 'print a list of iterations currently deployed'
	.action (cmd) ->
		console.log("Would output versions")

program
  .command 'generate [name]'
  .description 'Generate a new iteration'
  .option('-l, --language <language', "Language to use (coffee, js")
  .action generate

program.on 'option:config', ->
  console.log 'Not implemented'
  process.exit 1

program.on 'command:*', ->
  process.stderr.write(
    colors.red("Invalid command #{program.args.join(' ')}\nsee --help for valid commands")
    )
  process.exit(1)

program.parse process.argv
