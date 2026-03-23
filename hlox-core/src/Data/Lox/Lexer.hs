module Data.Lox.Lexer where

import Data.List.NonEmpty (NonEmpty)

-- | Position type
--   We can use this to track the position of tokens
--     in the sorce code and report error with line and column information
data Position = Position
  { line :: Int,
    column :: Int
  }
  deriving (Eq)

firstPos :: Position
firstPos = Position 1 1

nextPos :: Position -> Position
nextPos (Position r c) = Position r (c+1)

newLinePos :: Position -> Position
newLinePos (Position r _) = Position (r+1) 1

-- | Lexer Type
newtype Lexer a = Lexer
  {runLexer :: String -> NonEmpty (Located a)}

-- | Alphabet in Lexer
--   now, a is (Located Char) and
--   b is (Located Token)
class LexAlpha a b where
  interpret :: (Foldable t) => t a -> t (b, a)

-- Define lexer.
-- Before write lexer, need to associate the source string
-- with the position by which they can be located from
-- source and reported in error messages.
data Located a = Located Position a deriving (Eq)

coordinate :: a -> Located a
coordinate x = Located firstPos x

nextCoord :: (a -> Bool) -> Located a -> b -> Located b
nextCoord p (Located pos a) y =
  let next = if p a then newLinePos else nextPos
   in Located (next pos) y

coordinates :: (a -> Bool) -> [a] -> [Located a]
coordinates _ [] = []
coordinates predicate (x:xs) = helper (coordinate x) predicate xs
  where
    helper :: Located a -> (a -> Bool) -> [a] -> [Located a]
    helper px _ [] = [px]
    helper px isNewLine (y:ys) = let py = nextCoord isNewLine px y
                                  in px : helper py isNewLine ys

instance Functor Located where
  fmap f (Located pos x) = Located pos (f x)

instance Applicative Located where
  pure a = Located firstPos a
  (Located pos f) <*> (Located _ x) = Located pos (f x)

instance Monad Located where
  return = pure
  Located pos x >>= f = let Located _ y = f x in Located pos y

instance Show a => Show (Located a) where
  show (Located (Position r n) tok)
    = "("
    <> show r
    <> ", "
    <> show n
    <> ") "
    <> show tok
