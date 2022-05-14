module Proof where

-- Propositional equality
infixl 0 ===
(===) :: a -> a -> a
(===) = const 