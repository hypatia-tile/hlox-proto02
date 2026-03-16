module Lox.Lexer.Operator where

import Control.Monad.State.Lazy
import Data.Lox.Lexer
import Data.Lox.Token
import Lox.Lexer

data OpDFA
  = S0
  | SGT1 Token
  | SGT2 Token

opDfa :: Char -> StateT OpDFA Maybe ()
opDfa c = StateT $ dfa c
  where
    dfa :: Char -> OpDFA -> Maybe ((), OpDFA)
    dfa '(' S0 = Just ((), SGT1 TokLeftParen)
    dfa ')' S0 = Just ((), SGT1 TokRightParen)
    dfa '{' S0 = Just ((), SGT1 TokLeftBrace)
    dfa '}' S0 = Just ((), SGT1 TokRightBrace)
    dfa ',' S0 = Just ((), SGT1 TokComma)
    dfa '.' S0 = Just ((), SGT1 TokDot)
    dfa '-' S0 = Just ((), SGT1 TokMinux)
    dfa '+' S0 = Just ((), SGT1 TokPlus)
    dfa ';' S0 = Just ((), SGT1 TokSemicolon)
    dfa '/' S0 = Just ((), SGT1 TokSlash)
    dfa '*' S0 = Just ((), SGT1 TokStar)
    dfa '!' S0 = Just ((), SGT1 TokBang)
    dfa '=' S0 = Just ((), SGT1 TokEqual)
    dfa '>' S0 = Just ((), SGT1 TokGreater)
    dfa '<' S0 = Just ((), SGT1 TokLess)
    dfa '=' (SGT1 TokBang) = Just ((), SGT2 TokBangEqual)
    dfa '=' (SGT1 TokEqual) = Just ((), SGT2 TokEqualEqual)
    dfa '=' (SGT1 TokGreater) = Just ((), SGT2 TokGreaterEqual)
    dfa '=' (SGT1 TokLess) = Just ((), SGT2 TokLessEqual)
    dfa _ (SGT1 tok) = Just ((), SGT1 tok)
    dfa _ _ = Nothing

-- | Pares operator token
parseOperator :: StateT [Located Char] Maybe (Located Token)
parseOperator = do
  Located (c1, pos) <- advance
  st <- get
  case evalState peek st of
    Nothing -> do
      case execStateT (opDfa c1) S0 of
        Just (SGT1 tok) -> return $ Located (tok, pos)
        _ -> fail "No character remains"
    Just c2 -> do
      case execStateT (opDfa c1 >> opDfa c2) S0 of 
        Just (SGT1 tok) -> return $ Located (tok, pos)
        Just (SGT2 tok) -> do
          skip
          return $ Located (tok, pos)
        _ -> fail "No match operator"

-- TODO: write test
test :: IO ()
test = do
  let f = flip (evalState . enumString) (Position 1 1)
  let g = print . runStateT parseOperator . f
  g "hello"
  g "="
  g ">"
  g ">=hello"
  g ">==hello"
