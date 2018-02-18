# Rails DeCal Spring 2018 Homework 2

## Introduction
Hey there! Welcome to homework 2 of the Rails DeCal. By this week, the course will have covered routes, simple ruby syntax, and basic CRUD statements.

As you complete this homework, refresh your browser to observe changes you expect. If that doesn't work, try restarting the server.

Per usual, Google and Stack Overflow are your best friends when debugging.

## Setup:
To start everything off, fork this repository - there should be a fork button on the top right corner of the repo.

<b>After you fork</b>, run these commands to clone your newly forked repository:
```
git clone https://github.com/your_username/sp18-hw2
cd sp18-hw2
```

Next, install all the gems (Rails libraries) necessary by running:

```
bundle install
```

Then, start your server by running:
```
rails server
```
Try going to `localhost:3000` in your browser. But wait...it's broken. What's going on? Routes? Undefined?


## BUT WAIT (Preface)!

If you take a look at a couple of the classes in the `app/controllers/concerns/` directory, you'll see some weird functions - `attr_accessor` and `initialize`.

`initialize` is similar to Python's `__init__` method and is called every time you create a new object. If you do not define an `initialize` method, Ruby will just assume that your class has an empty initializor.

`attr_accessor` is used to define instance variables so that you can have both read access (via `your_class.instance_variable`) and edit access (via `your_class.instance_variable = some_value`). By default, instance variables are NOT accessible (getting or setting) outside of the class so you have to declare `attr_accessor` in order to enable this functionality. You can also be more specific and make some attributes readable (`attr_readable`) and some settable (`attr_writer`).

Also, you'll see a lot of `<%= some_variable %>`. This is embedded ruby, which we'll be covering next week.

## A Note on Views

In lecture we saw how the router helped our web application translate HTTP requests into controller actions. If you remember the MVC diagram, the controller's final step is to return a **view** back to the client, so we can see the results. You will need to have a basic understanding of how this works in order to complete the homework problems.

For example, we have the following line of code in `routes.rb`:

```ruby
get 'users', to: 'users#index'
```

When this HTTP request is received, it will be handled by the `UsersController`'s `index` action:

```ruby
class UsersController < ApplicationController
  def index
    @users = User.all
    render :index
  end
end
```

Take special note of the line `render :index`, and recall that Rails strives to be as minimally redundant as possible. This line looks through your `users` view folder (`app/views/users`) for a file called `index.html.erb` and then renders that. **The naming is essential.** How does it know to look through only the `users` view folder? Because this controller is **named** `UsersController`. If you misspell it or even use the singular form `UserController` you may face some nasty little bugs.

If that wasn't enough, the line `render :index` can actually be *completely omitted*:

```ruby
def index
  @users = User.all
end
```

Since our method is named `index`, the default behavior is to automatically render the view called `index.html.erb`. Remember this well because you will very rarely see the explicit `render` statement again.

## Alright, lets get crackin':

### Question 1
Here, we're going to look into a `POST` request.

If you look closely at the code at `home.html.erb`, you'll see a bunch of confusing code like this:

```
<%= form_tag stringify_path do... %>
```
Don't worry if this is confusing to you. We'll be covering forms in the future. What **is** important is that a form POSTs a request to a endpoint/path.

To fix the errors, route a path in the routes.rb file so that a POST request to `localhost:3000` (also known `'/'` or `root`) routes to the `stringify` method in `pages_controller.rb`. Be sure to give set the path prefix to `stringify` so we can reference it with the name  `stringify_path`

Now that we've gone through that hassle, we now face our second problem. If you try to submit the form, you get a views error message (missing template pages/stringify) if you check terminal window where you are running your rails server!

To fix this, update `app/controllers/concerns/stringify` such that the `what_am_i` method returns "You are nothing!" if `@name` or `@adjective` are blank, but returns "<em>your_name</em> is so <em>your_adjective</em>" if `@name` and `@adjective` are not blank.

Hint: The method `blank?` may be helpful. Also refer to the first lecture if you need a refresher on boolean logic or how to structure if-else blocks.

Once you're done, create a `stringify.html.erb` view (where should this file go?) and add

```
<%= @text %>
```

to the view. Now when you submit the form, nothing should error and you should see the result of your `what_am_i` method.

Hint: The associated view file of a controller method (ex: 'pages#home') should be named 'home.html.erb' and placed in the `views/pages` directory.

### Question 2

Now we're going to look at more routing + creating classes!

If you look at the Question 2 section on the home page, you'll see that we have another form! However, if you submit it you'll get an error message telling you that no route matches the request.

Let's fix this bug.

**Step 1**: `<%= form_tag age_path, method: :put do %>` tells Rails to create a `PUT` request to `/age` on form submission. Create an appropriate route in `routes.rb` to handle the form submission; direct it to the `person` method in `pages_controller.rb`, rather than the `age` method. This means that a GET request to `/age` will be handled by a different action than a PUT request to `/age`!

**Step 2**: in `/controllers/concerns`, implement a `Person` class whose `initialize` method accepts a name and age and creates an instance variable `@nickname` that is the first four letters of `@name` (use string/array splicing).

The `Person` class should have the following methods:
- `introduce`: returns a string with the instance's name and age
- `birth_year`: calculates what year they were born given an age in years (Bonus: try to implement this using `Time.now.year`)
    - Hint: the string `to_i` method might come in handy here
- `nickname`: returns the nickname

Submit the Question 2 form (which will direct you to `localhost:3000/age`) and validate you did this correctly.

Note: don't worry about blank form edge cases (which we practiced handling in Q1) and formatting.

### Question 3
Let's practice some HTML/CSS:

Create a view that can be seen if you go to `localhost:3000/me`. Just a friendly reminder, to do this you'll have to create a route, a controller action, and a view.

In this view, render your name, where you're from, your year (freshman/sophomore/junior/senior/etc), a fun fact, and what you're most excited about in this class. Try to have fun with this part! :)

**Bonus**: add and render a picture of yourself (upload your file into `assets/images`). Check out the rails `image_tag` helper.

**Bonus 2**: use CSS to style your text (add background colors, underline it, anything you want!)


Go to `localhost:3000/me` and validate you did this correctly.

## How to submit
You're done! Whew. Time to submit! Run these commands:
```
git add .
git commit -am "whatever message you want"
git push origin master
```
Fill out the submission form for this homework, which can be found on Piazza.
