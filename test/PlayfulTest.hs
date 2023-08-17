module PlayfulTest
    ( main
    ) where

import Playful (Optional(..))
import Test.HUnit

main :: IO Counts
main = runTestTT tests

tests :: Test
tests = TestList
    [ TestLabel "print optional" test1
    , TestLabel "print optional" test2
    ]

test1 :: Test
test1 = TestCase (assertEqual "Prints some" (show (Some 1 :: Optional Int)) "Some 1")

test2 :: Test
test2 = TestCase (assertEqual "Prints none" (show (None :: Optional Int)) "None")


