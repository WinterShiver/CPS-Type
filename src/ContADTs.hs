{-# LANGUAGE GADTs #-}

module ContADTs where 

import ADTs (Sum, Prod, Maybe')
-- import SumType
-- import ProdType

newtype ContMaybe r a = Maybe {runMaybe :: (a -> r) -> r -> r}
-- or: data ContMaybe r a = Sum r () a

evalMaybe :: ContMaybe (Maybe' a) a -> Maybe' a
evalMaybe (Maybe f) = f Right (Left ())

-- TODO: take ContMaybe (CPS Maybe Monad) as example, 
-- show that it's a superset of Maybe Monad

-- instance Functor Maybe -- Defined in ‘GHC.Base’
-- instance Applicative Maybe -- Defined in ‘GHC.Base’
-- instance Monad Maybe -- Defined in ‘GHC.Base’
-- instance Foldable Maybe -- Defined in ‘Data.Foldable’
-- instance Traversable Maybe -- Defined in ‘Data.Traversable’
-- instance Eq a => Eq (Maybe a) -- Defined in ‘GHC.Maybe’
-- instance Ord a => Ord (Maybe a) -- Defined in ‘GHC.Maybe’
-- instance Semigroup a => Monoid (Maybe a) -- Defined in ‘GHC.Base’
-- instance Semigroup a => Semigroup (Maybe a)
--   -- Defined in ‘GHC.Base’
