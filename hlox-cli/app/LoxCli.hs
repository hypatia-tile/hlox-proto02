module Main (main) where

import System.Environment (getArgs)
import qualified MyLib (someFunc)

main :: IO ()
main = do
  putStrLn "Hello, Haskell!"
  args <- getArgs
  MyLib.someFunc args
