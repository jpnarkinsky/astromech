# Load all required libraries.
gulp       = require 'gulp'
coffee = require 'gulp-coffee'

gulp.task 'coffee', -> 
  gulp.src './src/*.coffee'
    .pipe(coffee(bare: true))
    .pipe(gulp.dest('./js'))

# Default task call every tasks created so far.
gulp.task 'default', ['coffee']