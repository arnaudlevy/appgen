module Appgen
  class Loader
    def self.load(path=nil)
      # TODO load from local file or from local path or from distant path
      puts 'Loading custom app'
      "The app name is blogdemo.
There are posts.
A post has a title, a text (as text), a user, and comments.
There are users.
A user has a name.
There are comments.
A comment has a user."
    end
  end
end
