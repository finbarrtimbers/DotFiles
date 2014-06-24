# Finbarr’s dotfiles

Inspired by https://github.com/mathiasbynens/dotfiles.



### Sensible OS X defaults

When setting up a new Mac, you may want to set some sensible OS X defaults:

```bash
./.osx
```

### Install Homebrew formulae

When setting up a new Mac, you may want to install some common [Homebrew](http://brew.sh/) formulae (after installing Homebrew, of course):

```bash
brew bundle ~/Brewfile
```


### Install gtest

1. Get the googletest framework

$ wget http://googletest.googlecode.com/files/gtest-1.7.0.zip

2. Unzip and build google test

$ unzip gtest-1.7.0.zip
$ cd gtest-1.7.0
$ ./configure
$ make

3. "Install" the headers and libs on your system.

$ sudo cp -a include/gtest /usr/include
$ sudo cp -a lib/.libs/* /usr/lib/
gTestframework is now ready to use. Just don't forget to link your project against the library by include `-lgtest` in the compile command, e.g.

	g++ -lgtest -o test test.cpp

