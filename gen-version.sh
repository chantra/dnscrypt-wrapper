#!/bin/sh
# Generate version automatically.

version_file=version.h

if test -d .git; then
    version=$(git describe --always --match "v[0-9]*" | sed -e 's/-/./g' | sed -e 's/^v//g')
    if test -f "$version_file"; then
        VC=$(perl -ne 'print "$1" if m/.*the_version = "(.*)".*/' $version_file)
    else
        VC=unset
    fi

    if test "$VC" != "$version"; then
        echo "/* Automatically generated by $0 */
#ifndef VERSION_H
#define VERSION_H

const char *the_version = \"$version\";

#endif" > $version_file
    fi
fi
