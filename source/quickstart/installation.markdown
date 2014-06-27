# Installation

Zillabyte uses a command line interface(CLI) to allow the user to interact with the servers. This CLI is written in Ruby, and requires an environment suited to Ruby development. Once the CLI is installed, applications can be made in Ruby or other languages such as Python, and pushed to the servers via the CLI.

### Getting started

Zillabyte is distributed using the RubyGems package manager. This means you will need both the Ruby language runtime installed and RubyGems to begin using Zillabyte. Installing the `zillabyte` gem will download both the CLI and runtime packages.

Mac OS X comes prepackaged with both Ruby and Rubygems, however, some of the Zillabyte's dependencies need to be compiled during installation. These dependencies are similar to those found in other Ruby projects such as Rails.

The installation of these dependencies on OS X requires Xcode. Xcode can be installed via the [Mac App Store](http://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12). Alternately, if you have a free Apple Developer account, you can just install Command Line Tools for Xcode from their [downloads page](https://developer.apple.com/downloads/index.action).


### Install Zillabyte

Once you have Ruby and RubyGems up and running, execute the following from the command line:

``` bash
$ gem install zillabyte
```
note: The `zillabyte` gem does not need to be installed using sudo or as the super user, and we highly encourage you not to do so. If you are having issues with your installation, see below



### Troubleshooting your installation


If the gem installation does complete successfully, you may need to install a version of ruby that is known to be compatible with Zillabyte. 


Zillabyte works best with Ruby version 1.9.3. To manage your Ruby version, the RVM (Ruby Version Manager) allows you to easily install, manage, and work with multiple ruby environments. 


1) Install [RVM](https://rvm.io/) 

```bash
$ \curl -L https://get.rvm.io | bash -s stable --ruby=1.9.3
``` 

2) Load RVM into your environment

```bash
$ source "$HOME/.rvm/scripts/rvm"
``` 

We recommend adding this line to your `.bash_profile` or `.bashrc` files to load on terminal startup.

3) Install ruby 1.9.3-p448 

```bash
$ rvm install ruby-1.9.3-p448
```

4) Make 1.9.3-p448 the default.

```bash
$ rvm use ruby-1.9.3-p448 --default
```

5) Install Zillabyte. You may want to run `gem uninstall zillabyte` before retrying if you are encountering an error.


If you are still having issues with installation, please contact our team and we will gladly assist you through the process.
