#!/bin/bash

mkdir -p hlox-cli
cd hlox-cli
cabal init --non-interactive \
  --package-name=hlox-cli \
  --license=MIT \
  --libandexe \
  --tests \
  --main-is=LoxCli.hs \
  --language=Haskell2021
