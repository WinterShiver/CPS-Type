module SumType where 

newtype Sum r a b = Sum {runSum :: (a -> r) -> (b -> r) -> r}

-- isomorphism to sum type

evalSum :: Sum (Either a b) a b -> Either a b
evalSum (Sum f) = f Left Right


-- TODO
-- compare with Either Monad

-- instance Functor (Either a) -- Defined in ‘Data.Either’
-- instance Applicative (Either e) -- Defined in ‘Data.Either’
-- instance Monad (Either e) -- Defined in ‘Data.Either’
-- instance Semigroup (Either a b) -- Defined in ‘Data.Either’
-- instance Foldable (Either a) -- Defined in ‘Data.Foldable’
-- instance Traversable (Either a) -- Defined in ‘Data.Traversable’
-- instance (Eq a, Eq b) => Eq (Either a b)
--   -- Defined in ‘Data.Either’
-- instance (Ord a, Ord b) => Ord (Either a b)
--   -- Defined in ‘Data.Either’