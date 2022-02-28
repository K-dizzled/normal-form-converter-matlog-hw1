module Main (main) where

import Test.Tasty.HUnit
import Test.Tasty
import MyLib



main :: IO ()
main = defaultMain tests

tests:: TestTree
tests = testGroup "My test group"
    [
        testCase "test nnf 1" $ toNNF (Var "x") @?= Var "x",
        testCase "test nnf 2" $ toNNF (Var "x" :->: Var "y") @?= Not (Var "x") :|: Var "y",
        testCase "test cnf 1" $ toCNF (Var "c" :|: (Var "a" :&: Var "b")) @?= (Var "c" :|: Var "a") :&: (Var "c" :|: Var "b"),
        testCase "test cnf 2" $ toDNF (Var "a" :&: Not (Not (Var "b") :|: Var "c")) @?= Var "a" :&: (Var "b" :&: Not (Var "c")),
        testCase "test dnf 1" $ toDNF (Var "c" :&: (Var "a" :|: Var "b")) @?= (Var "c" :&: Var "a") :|: (Var "c" :&: Var "b")
    ]

