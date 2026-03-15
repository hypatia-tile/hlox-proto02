module MyLib (someFunc) where

import Data.Lox.Token
import Lox.Repl
import Lox.ReadFile

someFunc :: [String] -> IO ()
someFunc procType = dispatch procType lexer

lexer :: Lexer
lexer = Lexer $ \input -> map Token (words input)

dispatch :: [String] -> Lexer -> IO ()
dispatch procType = case task procType of
  Just action -> action
  Nothing -> undefined

task :: [String] -> Maybe (Lexer -> IO ())
task ["repl"] = Just dispatchRepl
task ["file" , x] = Just $ dispatchFile x
task _ = Nothing
