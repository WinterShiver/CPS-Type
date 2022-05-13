module Cont where

newtype Cont r a = Cont {runCont :: (a -> r) -> r}

-- Monad instance

instance Functor (Cont r) where
    fmap f (Cont m) = Cont (\k -> m (k . f))
    
instance Applicative (Cont r) where
    pure = return
    m <*> a = m >>= (`fmap` a)

instance Monad (Cont r) where
    return x = Cont (\k -> k x)
    Cont m >>= f = Cont (\k -> m (\v -> runCont (f v) k))

-- Properties proof

-- Propositional equality
infixl 0 ===
(===) :: a -> a -> a
(===) = const 

-- Functor

-- Identity: fmap id = id
identityF (Cont m) = fmap id (Cont m)
    === Cont (\k -> m (k . id))
    === Cont (\k -> m k)
    === Cont m
    === id (Cont m)

-- Composition: fmap (f . g)  ==  fmap f . fmap g
compositionF f g (Cont m) = (fmap f . fmap g) (Cont m)
    === fmap f (fmap g (Cont m))
    === fmap f (Cont (\k -> m (k . g)))
    === Cont (\k' -> (\k -> m (k . g)) (k' . f))
    === Cont (\k' -> m ((k' . f) . g))
    === Cont (\k' -> m (k' . (f . g)))
    === fmap (f . g) (Cont m)

-- Applicative

-- Identity: pure id <*> v = v
identityA v = pure id <*> v
    === pure id >>= (`fmap` v)
    === Cont (\k -> k id) >>= (`fmap` v)
    === Cont (\k -> (\k' -> k' id) (\v' -> runCont ((`fmap` v) v') k))
    === Cont (\k -> (\v' -> runCont ((`fmap` v) v') k) id)
    === Cont (\k -> runCont ((`fmap` v) id) k)
    === Cont (runCont (fmap id v))
    === Cont (runCont v)
    === v

-- Homomorphism: pure f <*> pure x = pure (f x)

lemma1 f x = Cont f <*> Cont x
    === Cont f >>= \h -> fmap h (Cont x)
    === Cont (\k -> f (\v -> runCont (fmap v (Cont x)) k))

lemma2 f x = pure f <*> Cont x
    === Cont (\k -> k f) <*> Cont x
    === Cont (\k -> (runCont (fmap f (Cont x)) k))
    === Cont (runCont (fmap f (Cont x)))
    === fmap f (Cont x)

homomorphismA f x = pure f <*> pure x
    === fmap f (Cont ($ x))
    === Cont (\k -> ($ x) (k . f))
    === Cont (\k -> k . f $ x)
    === Cont ($ f x)
    === pure (f x)

-- Interchange: u <*> pure y = pure ($ y) <*> u

interchangeA u y = Cont u <*> pure y
    === Cont u >>= \h -> fmap h (pure y)
    === Cont u >>= \h -> pure (h y)
    === Cont (\k -> u (\v -> runCont (pure (v y)) k))
    === Cont (\k -> u (\v -> k (v y)))
    === Cont (\k -> u (k . ($ y)))
    === fmap ($ y) (Cont u)
    === pure ($ y) <*> Cont u

-- Composition: pure (.) <*> u <*> v <*> w = u <*> (v <*> w)

compositionA u v w = pure (.) <*> Cont u <*> Cont v <*> Cont w
    === fmap (.) (Cont u) <*> Cont v <*> Cont w
    === Cont (\k -> u (k . (.))) <*> Cont v <*> Cont w
    === Cont (\k -> u ((\v' -> runCont (fmap v' (Cont v)) k) . (.))) <*> Cont w
    === error "I am exhausted, assume this is true"

-- Monad

-- Left identity: return a >>= k = k a

leftIdentityM a k = return a >>= k
    === Cont (\k' -> k' a) >>= k
    === Cont (\k'' -> (\k' -> k' a) (\v -> runCont (k v) k''))
    === Cont (\k'' -> runCont (k a) k'')
    === Cont (runCont (k a))
    === k a

-- Right identity: m >>= return = m

rightIdentityM (Cont m) = Cont m >>= return 
    === Cont (\k -> m (\v -> runCont (return v) k))
    === Cont (\k -> m (\v -> k v))
    === Cont (\k -> m k)
    === Cont m

-- Associativity: m >>= (\x -> k x >>= h) = (m >>= k) >>= h

associativityM (Cont m) k h = Cont m >>= (\x -> k x >>= h)
    === Cont (\k' -> m (\v -> runCont ((\x -> k x >>= h) v) k'))
    === Cont (\k' -> m (\v -> runCont (k v >>= h) k'))
    === Cont (\k'' -> m (\v -> runCont (Cont (\k' -> runCont (k v) (\v' -> runCont (h v') k'))) k''))
    === Cont (\k'' -> m (\v -> (\k' -> runCont (k v) (\v' -> runCont (h v') k')) k''))    
    === Cont (\k'' -> (\k' -> m (\v -> runCont (k v) k')) (\v -> runCont (h v) k''))
    === Cont (\k' -> m (\v -> runCont (k v) k')) >>= h 
    === (Cont m >>= k) >>= h

-- Associate to Applicative

-- pure === return

proof1 x = pure x === return x

-- m1 <*> m2 = m1 >>= (\x1 -> m2 >>= (\x2 -> return (x1 x2)))

proof2 m1 (Cont m2) = m1 <*> Cont m2
    === m1 >>= \x1 -> fmap x1 (Cont m2)
    === m1 >>= \x1 -> Cont (\k -> m2 (k . x1))
    === m1 >>= \x1 -> Cont (\k -> m2 (\v -> k (x1 v)))
    === m1 >>= \x1 -> Cont (\k -> m2 (\v -> runCont (return (x1 v)) k))
    === m1 >>= \x1 -> Cont m2 >>= \x2 -> return (x1 x2)

-- TODO: compare with identity monad

-- useful functions

-- evalCont :: Cont r r -> r
-- evalCont (Cont m) = m id

-- mapCont :: (r -> r) -> Cont r a -> Cont r a
-- mapCont f (Cont m) = Cont (f . m)

-- withCont :: ((b -> r) -> a -> r) -> Cont r a -> Cont r b
-- withCont f (Cont m) = Cont (m . f)