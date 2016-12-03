#!/usr/bin/env bash

# This script downloads CmdStan from GitHub
# and build it from source. It also runs the
# included example and all the tests that are
# run on travis.
#
# CmdStan is the comand line interface to the probabilistic
# programming language Stan. More information about Stan
# can be found at http://mc-stan.org/.

git clone https://github.com/stan-dev/cmdstan
pushd cmdstan

# Checkout latest release
git checkout master

# Or checkout v 2.12.0 Confirmed to work with Build 14393
# git checkout tags/v2.12.0

# Update submodules
git submodule update --init --recursive

# Build CmdStan in paralell. Change -j4 to match your machine
make build -j4

# Run the bernoulli example and show a summary of the samples
make examples/bernoulli/bernoulli -j4
examples/bernoulli/bernoulli sample data file=examples/bernoulli/bernoulli.data.R
bin/stansummary output.csv

# Run CmdStan tests
./runCmdStanTests.py -j4 src/test/interface

# Run Stan tests
pushd `git config -f .gitmodules --get submodule.stan.path`
./runTests.py -j4 src/test/unit/

# Run Stan Math tests
pushd `git config -f .gitmodules --get submodule.lib/stan_math.path`
./runTests.py -j4 test/unit/math/memory
./runTests.py -j4 test/unit/math/prim/scal
./runTests.py -j4 test/unit/math/prim/arr
./runTests.py -j4 test/unit/math/prim/mat
./runTests.py -j4 test/unit/math/rev/scal
./runTests.py -j4 test/unit/math/rev/arr
./runTests.py -j4 test/unit/math/rev/mat
./runTests.py -j4 test/unit/math/fwd/arr
./runTests.py -j4 test/unit/math/fwd/mat

popd; popd; popd
