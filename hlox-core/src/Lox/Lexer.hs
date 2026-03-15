module Lox.Lexer where

import Data.Lox.Lexer

enumChar :: Char -> Position -> (Located Char, Position)
enumChar x pos = (Located (x, pos), modPos x pos)
  where
    modPos :: Char -> Position -> Position
    modPos '\n' (Position l _) = Position (l + 1) 1
    modPos _ (Position l c) = Position l (c + 1)

-- | Enumerate source String
enumString :: [Char] -> [Located Char]
enumString srcStr = enumStringHelper (Position 1 1) srcStr
  where
    enumStringHelper :: Position -> [Char] -> [Located Char]
    enumStringHelper _ [] = []
    enumStringHelper pos (x : xs) =
      let (l, newPos) = enumChar x pos
       in l : enumStringHelper newPos xs
