module Data.Lox.Token where


-- | Token type placeholder
--   Now, we just wrap a string, define more specific token types later
data Token
  = -- Single-character tokens.
    TokLeftParen
  | TokRightParen
  | TokLeftBrace
  | TokRightBrace
  | TokComma
  | TokDot
  | TokMinux
  | TokPlus
  | TokSemicolon
  | TokSlash
  | TokStar
  | -- One or two character tokens.
    TokBang
  | TokBangEqual
  | TokEqual
  | TokEqualEqual
  | TokGreater
  | TokGreaterEqual
  | TokLess
  | TokLessEqual
  | -- Literals.
    TokIdentifier
  | TokString
  | TokNumber
  | -- Keywords.
    TokAnd
  | TokClass
  | TokElse
  | TokFalse
  | TokFun
  | TokFor
  | TokIf
  | TokNil
  | TokOr
  | TokPrint
  | TokReturn
  | TokSuper
  | TokThis
  | TokTrue
  | TokVar
  | TokWhile
  | -- EOF
    TokEof
  deriving (Show, Eq)
