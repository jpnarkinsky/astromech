Config = require '../config'
fs = require 'fs'
Inflector = require 'inflected'
logger = require '../logger'
moment = require 'moment'
path = require 'path'
prompts = require 'prompts'
templates = require '../iteration_templates'

module.exports = (name, cmd) ->
  if !name
    name = await prompts({
      type: 'text',
      name: 'name',
      message: 'What is the name for this migration?',
      validate: /\w+/.test(name),
    })

  version = moment().format("YYYYMMDDhhmmss")
  language = cmd.language || Config.defaultLanguage
  filename = "#{version}-#{Inflector.underscore  name.replace(/\s+/g, '-')}.#{language}"
  path = path.join(Config.iterationDir, filename)
  className =  Inflector.camelize(name.replace(/\s+/g, '_'))
  
  template = templates[language]
  throw new Error "Couldn't find iteration template for language #{language}" if (!template)
  
  rendered = template({
    className,
    version,
    name,
  })
  
  fs.writeFileSync(path, rendered)
  logger.info "Created new migration at #{filename}"
  
