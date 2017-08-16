const gulp = require('gulp');
const coffee = require('gulp-coffee');
const babel = require('gulp-babel');
const sass = require('gulp-sass');
const concat = require('gulp-concat');
const uglify = require('gulp-uglify');
const imagemin = require('gulp-imagemin');
const sourcemaps = require('gulp-sourcemaps');
const del = require('del');

const paths = {
  scripts: 'assets/js/*.js',
  images: 'assets/images/*.png',
  scss: 'assets/scss/*.scss'
};

// Not all tasks need to use streams
// A gulpfile is just another node program and you can use any package available on npm
gulp.task('clean', function() {
  // You can use multiple globbing patterns as you would with `gulp.src`
  return del(['build']);
});

gulp.task('dev-scripts', ['clean'], function() {
  // Minify and copy all JavaScript (except vendor scripts)
  // with sourcemaps all the way down
  return gulp.src(['assets/js/sortable.js', 'assets/js/app.js'])
    .pipe(sourcemaps.init())
      .pipe(babel({
            presets: [
                ['es2015', 'stage-0']
            ]
      }))
      .pipe(concat('all.min.js'))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('public/js'));
});

gulp.task('scripts', ['clean'], function() {
  // Minify and copy all JavaScript (except vendor scripts)
  // with sourcemaps all the way down
  return gulp.src(['assets/js/sortable.js', 'assets/js/app.js'])
    .pipe(sourcemaps.init())
      .pipe(babel({
            presets: [
                ['env', {modules: false}]
            ]
      }))
      .pipe(uglify())
      .pipe(concat('all.min.js'))
    .pipe(gulp.dest('public/js'));
});

// Copy all static images
gulp.task('images', ['clean'], function() {
  return gulp.src(paths.images)
    // Pass in options to the task
    .pipe(imagemin({optimizationLevel: 5}))
    .pipe(gulp.dest('public/images'));
});

// Compile scss
gulp.task('sass', function() {
  return gulp.src(paths.scss)
    .pipe(sourcemaps.init())
    .pipe(sass().on('error', sass.logError))
    .pipe(gulp.dest('public/css'));
});

// Rerun the task when a file changes
gulp.task('watch', function() {
  gulp.watch(paths.scripts, ['dev-scripts']);
  gulp.watch(paths.images, ['images']);
  gulp.watch(paths.scss, ['sass']);
});

// The default task (called when you run `gulp` from cli)
gulp.task('default', ['watch', 'dev-scripts', 'images', 'sass']);
gulp.task('production', ['scripts', 'images', 'sass'])