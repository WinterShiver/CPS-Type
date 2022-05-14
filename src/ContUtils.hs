module ContUtils where

import Cont

evalCont :: Cont r r -> r
evalCont (Cont m) = m id

mapCont :: (r -> r) -> Cont r a -> Cont r a
mapCont f (Cont m) = Cont (f . m)

withCont :: ((b -> r) -> a -> r) -> Cont r a -> Cont r b
withCont f (Cont m) = Cont (m . f)