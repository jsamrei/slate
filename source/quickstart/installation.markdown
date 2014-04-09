# Installation

Zillabyte is distributed using the RubyGems package manager. This means you will need both the Ruby language runtime installed and RubyGems to begin using Zillabyte.

Mac OS X comes prepackaged with both Ruby and Rubygems, however, some of the Zillabyte's dependencies need to be compiled during installation and on OS X that requires Xcode. Xcode can be installed via the [Mac App Store](http://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12). Alternately, if you have a free Apple Developer account, you can just install Command Line Tools for Xcode from their [downloads page](https://developer.apple.com/downloads/index.action).

Once you have Ruby and RubyGems up and running, execute the following from the command line:

``` bash
$ gem install zillabyte
```

If this does not work, you may need to install a ruby that is known to be compatible with Zillabyte. 

1) Install [RVM](https://rvm.io/).  

```bash
$ \curl -L https://get.rvm.io | bash -s stable --ruby=1.9.3
``` 

2) Install ruby 1.9.3-p448. 

```bash
$ rvm install ruby-1.9.3-p448
```

3) Make 1.9.3-p448 the default.  

```bash
$ rvm use ruby-1.9.3-p448 --default
```

