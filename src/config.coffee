find = require 'find'
fs = require 'fs'
logger = require './logger'
Joi = require 'joi'
path = require 'path'
util = require './util'
yaml = require 'js-yaml'

schema = Joi.object().keys({
  project: Joi.string().min(1).required(),
  contexts: Joi.object().pattern(/^\w+$/, Joi.object().keys({
    services: Joi.array().items({
      name: Joi.string().regex(/^\w+$/).required(),
      adapter: Joi.string().regex(/^\w+$/).required(),
      arguments: Joi.object().optional(),
    })
  })).required()
})

class Config
  @getter "defaultLanguage", -> 'coffee'
  @getter "iterationDir", -> path.join(@root, "iterations")
  @getter "root", -> path.dirname(@configFile)
  
  constructor: ->
    @load(global.configPath)

  load: (filename = null) ->
    @configFile = @findConfig(filename)
    logger.info("Using config #{@configFile}")
    config = yaml.safeLoad(fs.readFileSync(@configFile), 'utf8')
    result = schema.validate(config)
    if (!result)
      logger.error("Invalid configuration file at #{@configFile}")
      process.exit(1)
    
  
  findConfig: (filename = null) ->
    # try to find an astromech.yaml file.
    return filename if filename != null
  
    try
      filenames = find.fileSync(/astromech.yaml/, process.cwd())
      if filenames.length > 1
        throw new Error("""
        Found multiple instances of astromech.yaml in current dir: (#{filenames.join(', ')})
        """)

      return filenames[0]
    catch err
      throw new Error("""
      Couldn't find astromech.yaml in current dir.
      """)


module.exports = new Config()
    