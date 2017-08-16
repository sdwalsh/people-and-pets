# People and Pets | p&p
## Wistia Full Stack Developer Challenge

People and Pets is my solution for the technical assessment.

## Language and Stack
### Rundown of the tech stack used
| Type                | Solution                        | Why?                             |
|---------------------|---------------------------------|----------------------------------|
| Language            | Ruby                            |                                  |
| Framework           | Sinatra                         | Lightweight and small framework  |
| Templating          | Haml                            | Clean and simple syntax          |
| Styling             | SCSS                            | Variables, mixins, and more      |
| Grid                | Neat                            | Simple scss grid framework       |
| Frontend Javascript | ES6+                            | Promises!                        |
| Frontend Libraries  | Modified Sortable.js by Hubspot | Very small framework             |
| Asset Pipeline      | Gulp                            | Compile and minify SCSS and ES6+ |
| Testing             | RSpec and Capybara              |                                  |

### In depth reasoning
A theme throughout my tech stack is minimalism and simplicity. I consistantly chose lighterweight solutions when possible while avoiding solutions that might add or expose unnecessary complexity.

#### Language
Out of the options of Ruby, Python, and Elixir I only had significant experience with Ruby. Although I was tempted to use Elixir (since I've used OCaml in the past) I ultmately decided to stick with what I knew best - Ruby.

#### Framework
Considering the size of the project (really only needing two routes, `GET '/'` and `POST '/upload'`) I decided forgo the niceties of Rails and stick to a ligherweight framework that better matched the project size. Sinatra was the perfect match. Sinatra even allowed the main application file to stay below 100 lines (with comments)!

#### SCSS
I've had a lot of luck with thoughtbot's SCSS libaries in the past (primarily [Bourbon](http://bourbon.io/), [Neat](http://neat.bourbon.io/)) and decided to use Neat - this time without Bourbon - for the SCSS / grid framework. The mixin was small and allowed for quick prototyping.

#### Javascript
I originally wrote the primary application's javascript file using ES5, jQuery, Moment.js, and Sortable. When compiled all these dependecies made the single page applicaiton *very* heavy. I refactored the application file to use ES6+ features and dropped the jQuery and Moment.js dependencies which reduced the production version of `app.js` from `~16KB` to a featherweight `~2.8KB`.

#### Asset Pipeline
When I began writing the application I stuck to Rack's SASS plugin for SCSS compliation.
```ruby
require 'sass/plugin/rack'
use Sass::Plugin::Rack
```
Once it became apparent that I needed to refactor my javascript I decided to change the asset pipeline to use [Gulp](https://gulpjs.com/). Gulp allowed me to use ES6+ features and minify my javascript, SCSS, and images files.

```javascript
gulp.task('default', ['watch', 'dev-scripts', 'images', 'sass']);
gulp.task('production', ['scripts', 'images', 'sass'])
```

#### Testing
I was a bit divided on how to test the application. Most of my Ruby testing experience was tied to Rails (which provides a lot of test helpers and easy to add solutions for testing). With this in mind, I stuck to RSpec and Capybara since I was more familiar with the DSL. I ran into some interesting problems with the javascript runtime for Capybara which I'll detail in a later section.

## Running People and Pets
| Task            | Command                        |
|-----------------|--------------------------------|
| Compile assets  | `gulp` or `gulp production`    |
| Run tests       | `xvfb-run -a bundle exec rake` |
| Run application | `rackup`                       |