module Lox.Repl where

import System.IO (isEOF, hFlush, stdout)
import Data.Lox.Token

dispatchRepl :: Lexer -> IO ()
dispatchRepl lex' = do
  putStr "hlox> "
  hFlush stdout
  let lexer' = runLexer lex'
  isClose <- isEOF
  if isClose
    then putStrLn "Exiting REPL. Goodbye!"
    else do
      (lexer' <$> getLine) >>= mapM_ (putStrLn . (("▶ " <>) . token))
      dispatchRepl lex'
