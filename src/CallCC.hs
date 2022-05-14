module CallCC where

import Cont 

callCC :: ((a -> r) -> Cont r a) -> Cont r a 
callCC f = Cont (\k -> runCont (f k) k)

throw :: (a -> r) -> a -> Cont r b
throw k x = Cont (const (k x))