---
title: Installation
---

Zillabyte is distributed using the RubyGems package manager. This means you will need both the Ruby language runtime installed and RubyGems to begin using Zillabyte.

Mac OS X comes prepackaged with both Ruby and Rubygems, however, some of the Zillabyte's dependencies need to be compiled during installation and on OS X that requires Xcode. Xcode can be installed via the [Mac App Store](http://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12). Alternately, if you have a free Apple Developer account, you can just install Command Line Tools for Xcode from their [downloads page](https://developer.apple.com/downloads/index.action).

Once you have Ruby and RubyGems up and running, execute the following from the command line:

``` bash
$ gem install zillabyte
```

## Setup 

First, [sign up](http://api.zillabyte.com/accounts/sign_up) to get your auth token.  You need an auth token to run your own app on Zillabyte. 

Second, install the CLI interface, which will give you access to all zillabyte commands. 

```bash
$ gem install zillabyte
```

Third, authenticate using your auth token. This will prompt you for your auth token.

```bash
$ zillabyte login
```

Now you're ready!



[HTML5 Boilerplate]: http://html5boilerplate.com/
[SMACSS]: http://smacss.com/
