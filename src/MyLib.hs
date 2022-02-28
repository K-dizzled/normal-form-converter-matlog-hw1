{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module MyLib where
import Data.Traversable (for)

type Lit = String

data Formula = Var Lit | 
               Formula :|: Formula | 
               Formula :&: Formula | 
               Formula :->: Formula | 
               Formula :<->: Formula |
               Not Formula
            deriving (Eq, Show)

toNNF :: Formula -> Formula
toNNF formula@(Var _)                     = formula
toNNF formula@(Not (Var _))               = formula
toNNF (Not (Not formula))                 = formula
toNNF (formula1 :&: formula2)             = toNNF formula1 :&: toNNF formula2
toNNF (Not (formula1 :&: formula2))       = toNNF $ Not formula1 :|: Not formula2
toNNF (formula1 :|: formula2)             = toNNF formula1 :|: toNNF formula2
toNNF (Not (formula1 :|: formula2))       = toNNF $ Not formula1 :&: Not formula2
toNNF (formula1 :->: formula2)            = toNNF $ Not formula1 :|: formula2
toNNF (Not (formula1 :->: formula2))      = toNNF $ formula1 :&: Not formula2
toNNF (formula1 :<->: formula2)           = toNNF $ (formula1 :&: formula2) :|: (Not formula1 :&: Not formula2)
toNNF (Not (formula1 :<->: formula2))     = toNNF $ (formula1 :|: formula2) :&: (Not formula1 :|: Not formula2)

toCNF :: Formula -> Formula
toCNF = toCNF' . toNNF

toDNF :: Formula -> Formula
toDNF = toDNF' . toNNF

applyDistributivityDisj :: Formula -> Formula -> Formula
applyDistributivityDisj a (b :&: c) = applyDistributivityDisj a b :&: applyDistributivityDisj a c
applyDistributivityDisj (b :&: c) a = applyDistributivityDisj a b :&: applyDistributivityDisj a c
applyDistributivityDisj a b         = a :|: b

applyDistributivityConj :: Formula -> Formula -> Formula
applyDistributivityConj a (b :|: c) = applyDistributivityConj a b :|: applyDistributivityConj a c
applyDistributivityConj (b :|: c) a = applyDistributivityConj a b :|: applyDistributivityConj a c
applyDistributivityConj a b         = a :&: b

toCNF' :: Formula -> Formula
toCNF' (formula1 :&: formula2) = toCNF' formula1 :&: toCNF' formula2
toCNF' (formula1 :|: formula2) = applyDistributivityDisj (toCNF' formula1) (toCNF' formula2)
toCNF' formula                 = formula

toDNF' :: Formula -> Formula
toDNF' (formula1 :|: formula2) = toDNF' formula1 :|: toDNF' formula2
toDNF' (formula1 :&: formula2) = applyDistributivityConj (toDNF' formula1) (toDNF' formula2)
toDNF' formula                 = formula