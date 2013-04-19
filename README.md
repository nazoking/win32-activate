# Win32::Activate

Activate current process window.

## Installation

Add this line to your application's Gemfile:

    gem 'win32-activate'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install win32-activate

## Usage

execute
     ruby -r rubygems -r win32/activate -e "system('notepad.exe');Win32::Activate.active"

after user close notepad window, command line window is activate

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
