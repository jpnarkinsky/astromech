fs = require 'fs'
Promise = require 'bluebird'
Mustache = require 'mustache'

manifest = [
  {
    name: steps,
    type: 'directory',
  },
  {
    name: stages,
    type: 'directory'
    content: [
      {
        type: "file",
        name: "dev.yaml",
        content: """
          name: development
          context: dev
        """
      },
    ],
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

processEntry = (entry) ->
  switch entry.type
  when  

module.exports = (dir='.', cmd) -> 
  try
    await Promise.map manifest, processEntry
