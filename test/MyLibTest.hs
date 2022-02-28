module Main (main) where

import Test.Tasty.HUnit
import Test.Tasty
import MyLib

main :: IO ()
main = defaultMain tests

tests:: TestTree
tests = testGroup "Form transformations tests" 
    [
        testGroup "NNF convertion tests"
            [
                testCase "test nnf 1" $ toNNF (Var "x") @?= Var "x",
                testCase "test nnf 2" $ toNNF (Not (Var "x")) @?= Not (Var "x"),
                testCase "test nnf 3" $ toNNF (Var "x" :&: Var "y") @?= Var "x" :&: Var "y",
                testCase "test nnf 4" $ toNNF (Var "x" :|: Var "y") @?= Var "x" :|: Var "y",
                testCase "test nnf 5" $ toNNF (Not (Var "x" :|: Var "y")) @?= Not (Var "x") :&: Not (Var "y"),
                testCase "test nnf 6" $ toNNF (Var "x" :->: Var "y") @?= Not (Var "x") :|: Var "y",
                testCase "test nnf 7" $ toNNF (Not (Not (Var "x") :|: Var "y")) @?= Var "x" :&: Not (Var "y"),
                testCase "test nnf 8" $ toNNF (Not (Not (Var "x") :&: Var "y")) @?= Var "x" :|: Not (Var "y"),
                testCase "test nnf 9" $ toNNF (Not (Not (Var "x") :|: Var "y") :&: Not (Not (Var "x") :|: Var "y")) @?= (Var "x" :&: Not (Var "y")) :&: (Var "x" :&: Not (Var "y")),
                testCase "test nnf 10" $ toNNF (Not (Not (Var "x") :&: Var "y") :&: Not (Not (Var "x") :|: Var "y")) @?= (Var "x" :|: Not (Var "y")) :&: (Var "x" :&: Not (Var "y")),
                testCase "test nnf 11" $ toNNF (Var "z" :|: (Var "x" :&: Var "y")) @?= Var "z" :|: (Var "x" :&: Var "y")
            ],
        testGroup "CNF convertion tests"
            [
                testCase "test сnf 1" $ toCNF (Var "x") @?= Var "x",
                testCase "test сnf 2" $ toCNF (Not (Var "x")) @?= Not (Var "x"),
                testCase "test сnf 3" $ toCNF (Var "x" :&: Var "y") @?= Var "x" :&: Var "y",
                testCase "test сnf 4" $ toCNF (Var "x" :|: Var "y") @?= Var "x" :|: Var "y",
                testCase "test сnf 5" $ toCNF (Not (Var "x" :|: Var "y")) @?= Not (Var "x") :&: Not (Var "y"),
                testCase "test сnf 6" $ toCNF (Var "x" :->: Var "y") @?= Not (Var "x") :|: Var "y",
                testCase "test сnf 7" $ toCNF (Not (Not (Var "x") :|: Var "y")) @?= Var "x" :&: Not (Var "y"),
                testCase "test сnf 8" $ toCNF (Not (Not (Var "x") :&: Var "y")) @?= Var "x" :|: Not (Var "y"),
                testCase "test сnf 9" $ toCNF (Not (Not (Var "x") :|: Var "y") :&: Not (Not (Var "x") :|: Var "y")) @?= (Var "x" :&: Not (Var "y")) :&: (Var "x" :&: Not (Var "y")),
                testCase "test сnf 10" $ toCNF (Not (Not (Var "x") :&: Var "y") :&: Not (Not (Var "x") :|: Var "y")) @?= (Var "x" :|: Not (Var "y")) :&: (Var "x" :&: Not (Var "y")),
                testCase "test сnf 11" $ toCNF (Var "z" :|: (Var "x" :&: Var "y")) @?= (Var "z" :|: Var "x") :&: (Var "z" :|: Var "y")
            ],
        testGroup "DNF convertion tests"
            [
                testCase "test dnf 1" $ toCNF (Var "x") @?= Var "x",
                testCase "test dnf 2" $ toDNF (Not (Var "x")) @?= Not (Var "x"),
                testCase "test dnf 3" $ toDNF (Var "x" :&: Var "y") @?= Var "x" :&: Var "y",
                testCase "test dnf 4" $ toDNF (Var "x" :|: Var "y") @?= Var "x" :|: Var "y",
                testCase "test dnf 5" $ toDNF (Not (Var "x" :|: Var "y")) @?= Not (Var "x") :&: Not (Var "y"),
                testCase "test dnf 6" $ toDNF (Var "x" :->: Var "y") @?= Not (Var "x") :|: Var "y",
                testCase "test dnf 7" $ toDNF (Not (Not (Var "x") :|: Var "y")) @?= Var "x" :&: Not (Var "y"),
                testCase "test dnf 8" $ toDNF (Not (Not (Var "x") :&: Var "y")) @?= Var "x" :|: Not (Var "y"),
                testCase "test dnf 9" $ toDNF (Not (Not (Var "x") :|: Var "y") :&: Not (Not (Var "x") :|: Var "y")) @?= (Var "x" :&: Not (Var "y")) :&: (Var "x" :&: Not (Var "y")),
                testCase "test dnf 10" $ toDNF (Not (Not (Var "x") :&: Var "y") :&: Not (Not (Var "x") :|: Var "y")) @?= ((Var "x" :&: Not (Var "y")) :&: Var "x") :|: ((Var "x" :&: Not (Var "y")) :&: Not (Var "y")),
                testCase "test dnf 11" $ toDNF (Var "z" :|: (Var "x" :&: Var "y")) @?= Var "z" :|: (Var "x" :&: Var "y")
            ]
    ]