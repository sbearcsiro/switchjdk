# Bash script to switch JDK versions for Mac users

This is a Bash script for Mac users to switch JDK versions on the command line. I found myself dissatisfied with the built-in <code>/usr/libexec/java_home</code> and the otherwise highly refined [jenv](https://github.com/gcuisinier/jenv).

# Installation

Paste the contents of `switchjdk-module.bash` into `~/.bash_profile`

## Alternate Homebrew Install

[See here](https://github.com/pcattori/homebrew-tap)

# Using switchjdk

1. You can do with JDK numbers (1.4 thru 1.9), or Java numbers (5 thru 9, err and '4' even though that was never released as that).
2. The script chooses the highest minor version of the JDK to use (say JDK 1.5.1 over 1.5.0).
3. I've not done any work for the OpenJDK varients of Java.
4. There's an attempt to verify the outcomes, and fast fail if it didn't work.  E.g. `switchjdk 5` on a new Mac will tell you that JDK 1.5 is really a symlink to JDK 6.

Contributions welcome!

# LICENSE

Copyright (c) 2015 - 2016 Paul Hammant

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
