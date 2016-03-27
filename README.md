# Bash profile function to switch JDK versions for Mac users

This is a Bash profile function for Mac users to switch JDK versions on the command line. I found myself dissatisfied with both the built-in <code>/usr/libexec/java_home</code> capability, as well as [jenv](https://github.com/gcuisinier/jenv) even though that the is highly refined.

# Installation

Paste the contents of `switchjdk-module.bash` into `~/.bash_profile`

## Alternate Homebrew Install

[See here](https://github.com/pcattori/homebrew-tap)

# Using switchjdk

```
$ switchjdk 7
JDK 1.7: JAVA_HOME and PATH changed for this terminal (and subprocesses).
```

1. You can do with JDK numbers (1.4 thru 1.9), or Java numbers (5 thru 9).
2. The script chooses the highest minor version of the JDK to use (say JDK 1.5.1 over 1.5.0). At the time of writing 9 is early access only, and I don't know what the numbers will look like for th real release until closer to that moment.
3. There's a `--quiet` or `-q` argument that stops it doing the final line.
4. Regardless of whether you have Maven installed or not, switchjdk modifies the tiny `~/.maven_rc` file appropriately.
5. The switchjdk command does not know about the OpenJDK varients of Java (Pull Requests accepted), just the Oracle and Apple ones.

The switchjdk command attempts to verify the outcomes, and fast fail if things are not right.  E.g. `switchjdk 5` on a new Mac will tell you that JDK 1.5 is really a symlink to JDK 6:

```
$ switchjdk 5
Requested JDK is not really installed. It is symlinked to JDK 1.6
```

Contributions welcome!

# LICENSE

Copyright (c) 2015 - 2016 Paul Hammant

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
