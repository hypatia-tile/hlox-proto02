module Main (main) where

import Control.Monad.State
import Data.Lox.Lexer
import Lox.Lexer
import Lox.Lexer.Operator
import Test.HUnit

main :: IO ()
main = runTestTTAndExit testOp1

-- TODO: write test
-- testOperator :: IO ()
-- testOperator = do
--   let f = flip (evalState . enumString) (Position 1 1)
--   let g = print . runStateT parseOperator . f
--   g "hello"
--   g "="
--   g ">"
--   g ">=hello"
--   g ">==hello"

testOp1 :: Test
testOp1 =
  TestCase
    ( do
        let source = evalState (enumString "hello") (Position 1 1)
        let result = runStateT parseOperator source
        assertEqual "Should be Nothing" Nothing result
    )

-- TODO: write more test cases for operators
