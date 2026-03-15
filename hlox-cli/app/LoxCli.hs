module Main (main) where

import System.Environment (getArgs)
import System.Exit (exitWith, ExitCode(..))
import qualified MyLib (someFunc)

-- | Main entry point for the Lox CLI application.
main :: IO ()
main = do
  putStrLn "Hello, Haskell!"
  args <- getArgs
  case dispatch args of
    Just procType -> MyLib.someFunc procType
    Nothing -> do
      putStrLn "Usage: hlox [repl | file <filename>]"
      exitWith $ ExitFailure 64
  where
    dispatch :: [String] -> Maybe [String]
    dispatch [] = Just ["repl"]
    dispatch ("file" : [x]) = Just ("file" : [x])
    dispatch _ = Nothing
