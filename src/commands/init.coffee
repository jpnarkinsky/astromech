fs = require 'fs'
path = require 'path'
Promise = require 'bluebird'
Mustache = require 'mustache'

manifest = [
  {
    name: "steps",
    type: 'directory',
  },
  # {
  #   name: 'stages',
  #   type: 'directory'
  #   items: [
  #     {
  #       type: "file",
  #       name: "dev.yaml",
  #       content: """
  #         name: development
  #         context: dev
  #       """
  #     },
  #   ],
  # },
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

processEntry = (entry, base, data, logger, depth = 0) ->
  indent = ' '.repeat(depth * 2)
  switch entry.type
    when "directory"
      dirName = path.join(base, entry.name)
      logger "#{indent}Creating path #{dirName}"
      if (!fs.existsSync(dirName))
        fs.mkdirSync(dirName)
      
      if entry.items
        processEntry(item, dirName, data, logger, depth + 1) for item in entry.items
    else
      logger ("Dir is #{base}, entry name is #{entry.name}")
      filePath = path.join(base, entry.name)
      logger "#{indent}Creating path #{filePath}"
      fs.writeFileSync(filePath, Mustache.render(entry.content, data))
  

module.exports = (dir = '.', cmd, logger) ->
  logger = console.log if !logger
  fs.mkdirSync(dir) if !fs.existsSync(dir)
  projectName = cmd.projectName || path.basename(path.resolve(dir))
  processEntry entry, dir, { projectName }, logger for entry in manifest
