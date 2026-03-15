module Lox.ReadFile where

import Data.Lox.Token

dispatchFile :: String -> Lexer -> IO ()
dispatchFile filename lexer = do
  contents <- readFile filename
  let lexer' = runLexer lexer
  mapM_ (putStrLn . (("▶ " <>) . token)) (lexer' contents)
