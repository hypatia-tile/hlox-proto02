module Data.Lox.Lexer where

import Data.Lox.Token

-- | Position type
--   We can use this to track the position of tokens
--     in the sorce code and report error with line and column information
data Position = Position
  { line :: Int,
    column :: Int
  }

-- | Lexer type
newtype Lexer = Lexer
  {runLexer :: String -> [(Token, Position)]}

-- We will define lexer.
-- Before we write lexer, we need to associate the source string
-- with the position by which we can locate the character from
-- source and make the error report
newtype Located a = Located (a, Position)

