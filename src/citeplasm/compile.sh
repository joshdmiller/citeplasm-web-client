#!/bin/bash
find . -name '*.coffee' -print | while read f; do echo Processing $f; coffee -cb $f; done
