colors = require('colors')
program = require('commander')
version = require('./version')

# Include commands
init = require('./commands/init')

program
	.name('astromech')
	.version(version)

program
	.command 'dump [version]'
	.description 'dump current state to stdout'
	.action (version, cmd) ->
		console.log("Would dump objects")

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

program.parse process.argv
program.outputHelp colors.red if (process.argv.length < 3)
