#!/bin/bash

# This script can be used to run flutter test for a given directory (defaults to the current directory)
# This will Perform the PR checks (mimicking the ci) and open the coverage report in a
# new window once it has run successfully.
#
# To run in main project:
# .prcheck.sh
#
# To run in other directory:
# .prcheck.sh ./path/to/other/project

set -e

# debug log
set -x

dart format lib test packages

flutter analyze lib test

bash coverage.sh

