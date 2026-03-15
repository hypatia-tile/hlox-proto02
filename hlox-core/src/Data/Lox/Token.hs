module Data.Lox.Token where

-- | Lexer type placeholder
--   define definite type later
newtype Lexer = Lexer
  { runLexer :: String -> [Token] }

-- | Token type placeholder
--   Now, we just wrap a string, define more specific token types later
newtype Token = Token
  {token :: String}
  deriving (Show, Eq)
