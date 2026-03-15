module Lox.Lexer where

import Control.Monad.State.Lazy
import Data.Lox.Lexer

-- | How cursor position moves
enumChar :: Char -> State Position (Located Char)
enumChar x = StateT $ \pos -> return (Located (x, pos), modPos x pos)
  where
    modPos :: Char -> Position -> Position
    modPos '\n' (Position l _) = Position (l + 1) 1
    modPos _ (Position l c) = Position l (c + 1)

-- | Enumerate source String
enumString :: [Char] -> State Position [Located Char]
enumString srcStr = traverse enumChar srcStr

-- TODO write test code
test1 :: IO ()
test1 = do
  let src = "Hello\nWorld"
  mapM_ print (evalState (enumString src) $ Position 1 1)

-- | Get head first from the list of characters with location
--   If no character is contained return Nothing
advance :: StateT [Located Char] Maybe (Located Char)
advance = StateT sepMay
  where
    sepMay :: [a] -> Maybe (a, [a])
    sepMay [] = Nothing
    sepMay (x : xs) = Just (x, xs)

skip :: StateT [Located Char] Maybe ()
skip = StateT $ \source -> case source of
  [] -> Nothing
  _ : rest -> return ((), rest)

peek :: State [Located Char] (Maybe Char)
peek = StateT $ \source -> case source of
  [] -> return (Nothing, source)
  (Located (x, _)) : _ -> return (Just x, source)
