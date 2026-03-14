#!/bin/bash

mkdir -p hlox-core
cd hlox-core
cabal init --non-interactive \
  --package-name=hlox-core \
  --license=MIT \
  --lib \
  --tests \
  --main-is=LoxCore.hs \
  --language=Haskell2021
