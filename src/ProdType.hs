module ProdType where 

newtype Prod r a b = Prod {runProd :: (a -> b -> r) -> r}

evalProd :: Prod (a, b) a b -> (a, b)
evalProd (Prod f) = f (,)

-- TODO
-- compare with (,) Monad

-- instance Monoid a => Applicative ((,) a) -- Defined in ‘GHC.Base’
-- instance Functor ((,) a) -- Defined in ‘GHC.Base’
-- instance Monoid a => Monad ((,) a) -- Defined in ‘GHC.Base’
-- instance Foldable ((,) a) -- Defined in ‘Data.Foldable’
-- instance Traversable ((,) a) -- Defined in ‘Data.Traversable’
-- instance (Eq a, Eq b) => Eq (a, b) -- Defined in ‘GHC.Classes’
-- instance (Ord a, Ord b) => Ord (a, b) -- Defined in ‘GHC.Classes’
-- instance (Monoid a, Monoid b) => Monoid (a, b)
--   -- Defined in ‘GHC.Base’
-- instance (Semigroup a, Semigroup b) => Semigroup (a, b)
--   -- Defined in ‘GHC.Base’
-- instance (Bounded a, Bounded b) => Bounded (a, b)
--   -- Defined in ‘GHC.Enum’