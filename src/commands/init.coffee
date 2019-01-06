fs = require 'fs'
path = require 'path'
Promise = require 'bluebird'
Handlebars = require 'handlebars'

manifest = [
  {
    name: "iterations",
    type: 'directory',
  },
  {
    name: "README.md",
    content: """
      # Astromech Project
      
      This directory contains an Astromech project.
    """
  },
  {
    name: "astromech.yaml",
    content: """
      project: {{projectName}}
    """
  }
]

processEntry = (entry, base, data, depth = 0) ->
  indent = ' '.repeat(depth * 2)
  switch entry.type
    when "directory"
      dirName = path.join(base, entry.name)
      log.info "#{indent}Creating path #{dirName}"
      if (!fs.existsSync(dirName))
        fs.mkdirSync(dirName)
      
      if entry.items
        processEntry(item, dirName, data, logger, depth + 1) for item in entry.items
    else
      log.info ("Dir is #{base}, entry name is #{entry.name}")
      filePath = path.join(base, entry.name)
      log.info "#{indent}Creating path #{filePath}"
      template = Handlebars.compile(entry.content)
      fs.writeFileSync(filePath, template(data))
  

module.exports = (dir = '.', cmd) ->
  fs.mkdirSync(dir) if !fs.existsSync(dir)
  projectName = cmd.projectName || path.basename(path.resolve(dir))
  processEntry entry, dir, { projectName } for entry in manifest
