module Main (main) where

import Test.HUnit

main :: IO ()
main = do
  runTestTTAndExit tests

tests :: Test
tests = TestList [TestLabel "test1" test1, TestLabel "test2" test2]

test1 :: Test
test1 = TestCase (assertEqual "for (foo 3)," (1,2) (foo 3))
test2 :: Test
test2 = TestCase (do (x,y) <- partA 3
                     assertEqual "for the first result of partA," 5 x
                     b <- partB y
                     assertBool ("(partB " ++ show y ++ ") failed") b)


foo :: Int -> (Int, Int)
foo 3 = (1, 2)
foo _ = undefined

partA :: Int -> IO (Int, Int)
partA 3 = return (5, 6)
partA _ = undefined

partB :: Int -> IO Bool
partB 6 = return True
partB _ = return False
