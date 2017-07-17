# Appgen

Rails prototyping is fast, appgen intends to make it even faster!
Describe your app in a text file, then run appgen.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'appgen'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install appgen

## Usage

Run

    $ appgen

By default appgen will run the first text file in the current directory.
If you want to use a specific file, then do 

    $ appgen a_specific_file.txt

## Writing app descriptions

Here is the rails blog demonstration as appgen description:

    The app name is blogdemo.
    There are posts.
    A post has a title, a text (as text), a user, and comments.
    There are users.
    A user has a name.
    There are comments.
    A comment has a user.

### Hosting

And if you want to host it on heroku, just add:

    The app is hosted on heroku.

It will attempt to set the remote heroku host.
If the app does not exist, it will attempt to create it.

If the heroku app name is different from the app name, use:

    The app is hosted on heroku, by the name of blogdemo.

If you want the app to be created in Europe, use:

    The app is hosted on heroku in Europe.

### Examples

Todo list
    
    The app name is mytodolist.
    There are actions.
    An action has a title, a done status (boolean) and a user.
    There are users.
    A user has a first name, a last name, and an email.
    Users can login.
    The app has an admin area.
    The app is hosted on heroku.

### Components used

The app generated use these gems by default
- pg 
- simple_form
- bootstrap
- kaminari

### Roadmap
- make it work
- make default route to first entity described
- add attachments (paperclip, aws)
- add navigation (simple-navigation)
- add breadcrumb (breadcrumbs_on_rails)
- add admin (with bootstrap theme, admin namespace, navigation)
- add login (devise)

### References
- https://github.com/zsiec/gypsum
- https://github.com/thoughtbot/suspenders
- http://guides.rubyonrails.org/rails_application_templates.html
- https://prelang.com
- https://github.com/mjacobus/koine-appgenerator


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/arnaudlevy/appgen. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Appgen project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/arnaudlevy/appgen/blob/master/CODE_OF_CONDUCT.md).
