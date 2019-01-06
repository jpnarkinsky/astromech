fs = require 'fs'
initCmd = require './init'
path = require 'path'
remove = require 'remove'
yaml = require 'js-yaml'

uniqueId = (length = 8) ->
  id = ""
  id += Math.random().toString(36).substr(2) while id.length < length
  id.substr 0, length

  
describe 'init', ->
  projectPath = null

  beforeEach ->
    id = uniqueId()
    projectPath = "/var/tmp/astromech-test-#{id}"
    initCmd(projectPath, { projectName: 'testproject' }, () -> null)
    
  afterEach ->
    remove.removeSync projectPath
  
  it 'should create the base directory of the project', ->
    expect(fs.existsSync(projectPath)).toBeTruthy()

  it 'should create the iterations directory of the project', ->
    expect(fs.existsSync(path.join(projectPath, 'iterations'))).toBeTruthy()
  
  it 'should create the project configuration file', ->
    expect(fs.existsSync(path.join(projectPath, 'astromech.yaml'))).toBeTruthy()

  it 'should initiate the project configuration file with the project name', ->
    config = yaml.safeLoad(fs.readFileSync(path.join(projectPath, 'astromech.yaml'), 'utf8'))
    expect(config.project).toBe('testproject')
