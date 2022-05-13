{-# LANGUAGE GADTs #-}

module ADTs where 

type Sum = Either
type Prod = (,)

-- 1. data constructors

type Maybe' a = Sum () a

-- 2. data types

data Person = Person {
    name :: String,
    gender :: Bool,
    age :: Int
}

type Person' = Prod (Prod String Bool) Int

-- 3. GADTs; recursive data types

data List a where
    Nil :: List a
    Cons :: a -> List a -> List a

newtype List' a = List {runList :: Sum () (Prod a (List' a))}