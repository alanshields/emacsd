#!/bin/sh

# for macs
/Applications/Emacs.app/Contents/MacOS/Emacs -batch -nw -l ~/.emacs.d/init.el --eval '(my-byte-compile-initd)'
