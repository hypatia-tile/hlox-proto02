module Data.Lox.Lexer where

import Data.Lox.Token

-- | Position type
--   We can use this to track the position of tokens
--     in the sorce code and report error with line and column information
data Position = Position
  { line :: Int,
    column :: Int
  }
  deriving (Eq)

-- | Lexer type
newtype Lexer = Lexer
  {runLexer :: String -> [(Token, Position)]}

-- Define lexer.
-- Before write lexer, need to associate the source string
-- with the position by which they can be located from
-- source and reported in error messages.
newtype Located a = Located (a, Position) deriving (Eq)

instance Show a => Show (Located a) where
  show (Located (tok, Position l n))
    = "("
    <> show l
    <> ", "
    <> show n
    <> ") "
    <> show tok
