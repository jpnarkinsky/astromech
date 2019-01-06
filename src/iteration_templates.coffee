Handlebars = require 'handlebars'

module.exports = {
  js: Handlebars.compile("""
  class {{{className}} extends Iteration {
    version='{{version}}';
    name='{{name}}';

    up() {
      // Add code to perform this iteration here
    }

    down() {
      // Add code to revert this iteration here
    }
  }

  module.exports = {{className}};
  """),
  coffee: Handlebars.compile("""
  class {{className}} extends Iteration
    @version="{{version}}"
    @name="{{name}}"

    up: ->
      // add code here to perform iteration
    
    down: ->
      // add code her to revert iteration
  """)
}
