# People and Pets | p&p
## Wistia Full Stack Developer Challenge

People and Pets is my solution for the technical assessment. 

I primarily worked on the afternoon of 8/10, the night of 8/15, and the morning of 8/16.

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

#### p&p should run on 
* `Chrome 49+` 
* `Edge 14+` 
* `Firefox 52+` 
* `Safari 10.1+` 

**Important:** People and Pets has only been tested on `Arch Linux` using `Chromium 60` and `Firefox Nightly 57`

### In depth reasoning
A theme throughout my tech stack is minimalism and simplicity. I consistently chose lightweight solutions when possible while avoiding solutions that might add or expose unnecessary complexity and refactored files to reduce dependencies.

#### Language
Out of the options provided - Ruby, Python, and Elixir - I only had significant experience with Ruby. Although I was tempted to use Elixir (since I've used OCaml in the past and enjoy functional languages) I ultimately decided to stick with what I knew best - Ruby.

#### Framework
Considering the size of the project (really only needing two routes, `GET '/'` and `POST '/upload'`) I decided forgo the niceties of Rails and stick to a lightweight framework that better matched the project size. Sinatra was the perfect match. Sinatra even allowed the main application file to stay below 100 lines (with comments)!

#### SCSS
I've had a lot of luck with thoughtbot's SCSS libraries in the past (primarily [Bourbon](http://bourbon.io/), [Neat](http://neat.bourbon.io/)) and decided to use Neat - this time without Bourbon - for the SCSS / grid framework. The mixin was small and allowed for quick prototyping.

#### Javascript
I originally wrote the primary application's javascript file using ES5, jQuery, Moment.js, and Sortable. When compiled all these dependencies made the single page application *very* heavy. I refactored the application file to use ES6+ features and dropped the jQuery and Moment.js dependencies which reduced the production version of `app.js` from `~16KB` to a featherweight `~2.8KB`.

When I refactored I used the [Fetch API](http://caniuse.com/#search=Fetch) and dropped support for older browsers and Internet Explorer completely. If necessary older browser support could be maintained with the use of a polyfill.

#### Asset Pipeline
When I began writing the application I stuck to Rack's SASS plugin for SCSS compilation.
```ruby
require 'sass/plugin/rack'
use Sass::Plugin::Rack
```
Once it became apparent that I needed to refactor my javascript I decided to change the asset pipeline to [Gulp](https://gulpjs.com/). Gulp allowed me to use ES6+ features and minify my javascript, SCSS, and images files.

```javascript
gulp.task('default', ['watch', 'dev-scripts', 'images', 'sass']);
gulp.task('production', ['scripts', 'images', 'sass'])
```

#### Testing
I was a bit divided on how to test the application. Most of my Ruby testing experience was tied to Rails (which provides a lot of test helpers and easy to add solutions for testing). With this in mind, I stuck to RSpec and Capybara since I was more familiar with the DSL. I ran into some interesting problems with the javascript runtime for Capybara which I'll detail in a later section.

## Running People and Pets
I originally planned on including deployment scripts using [Capistrano](http://capistranorb.com/) but ultimately scrapped plans as time became crunched.
| Task            | Command                        |
|-----------------|--------------------------------|
| Compile assets  | `gulp` or `gulp production`    |
| Run tests       | `xvfb-run -a bundle exec rake` |
| Run application | `rackup`                       |

# Thoughts & Post Mortem
## Points of Interest
### Javascript
I originally decided to avoid a javascript compilation pipeline and wrote the application's primary javascript file in `ES5` using `jQuery` for DOM manipulation. When I finished I had a clean small app.js file, but had heavy dependencies (`jQuery`, `Moment.js`).

I ended up refactoring app.js. 

* `jQuery` was easily factored out by using handy ES6+ features. I
* `Moment.js` was only used to quickly parse dates (`Date.parse()` is implementation dependent if not using the ISO format). Easy replacement. Since Moment was only used during a comparison *and* since the server responds with a consistent date format MM/DD/YYYY it was easy to split the date and create a new Date for comparisons. Code below.
```javascript
// Remove Moment for date parsing
comparator: function(a) {
    var aArray = a.split('/');
    // ISO = YYYY MM DD - remember that months are 0 based
    var dateA = new Date(aArray[2], aArray[0] - 1, aArray[1]);
    return dateA || 0;
}
```

### RSpec and Capybara

### Random thoughts
Sometimes picking a smaller framework increases the work and time required to create a running product. Sinatra comes with almost nothing - so small that Sinatra doesn't even call itself a framework. If time was critical, Rails would have been a better solution (convention over configuration - includes everything *and* the kitchen sink). It's quicker to prototype and build when you don't have to figure out configurations.

Start with a asset pipeline.

Don't introduce dependencies unless you absolutely must. It's hard to refactor.

It took a lot longer than I expected to write this readme!

#### END. Coffee and cereal.
```
  ;)( ;
 :----:     o8Oo./
C|====| ._o8o8o8Oo_.
 |    |  \========/
 `----'   `------'
 Coffee and cereal by Hayley Jane Wakenshaw
 http://www.ascii-code.com/ascii-art/food-and-drinks/coffee-and-tea.php
 ```
