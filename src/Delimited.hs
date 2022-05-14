module Delimited where

import Cont
import ContUtils
import Control.Monad (liftM, liftM2)

import Proof ((===))

-- shift and reset

reset :: Cont r r -> Cont r' r
reset = return . evalCont

shift :: ((a -> r) -> Cont r r) -> Cont r a
shift f = Cont (evalCont . f)

-- Properties

-- prop1: shift f >>= return = shift f

lemma1 f k = shift f >>= k
    === Cont (evalCont . f) >>= k
    === Cont (\k' -> (evalCont . f) (\v -> runCont (k v) k'))
    === Cont (\k' -> (evalCont . f) (($ k') . runCont . k))

proof1 f = shift f >>= return
    === Cont (\k -> (evalCont . f) (($ k) . runCont . return))
    === Cont (\k -> (evalCont . f) k)
    === Cont (evalCont . f) 
    === shift f

-- prop2: reset (shift f >>= k) = reset (f (evalCont . k))

proof2 f k = reset (shift f >>= k)
    === (return . evalCont) (Cont (\k' -> (evalCont . f) (($ k') . runCont . k)))
    === return ((evalCont . f) (($ id) . runCont . k))
    === (reset . f) (($ id) . runCont . k)
    === (reset . f) (evalCont . k)
    === reset (f (evalCont . k))

-- Comments: 
-- `shift f` captures the continuation up to the nearest enclosing `reset` and passes it to `f`
-- the captured continuation is replaced with the output of `f`
-- the updated context up to the enclosing reset becomes the output of `f`

-- prop3: reset (return m) = return m

proof3 m = reset (return m)
    === return (evalCont (return m))
    === return m

-- Comments:
-- `reset m` delimits the continuation of any `shift` inside `m`

-- prop4 (composition)
-- TODO: there should be a proper form like 
-- `g (shift f >>= k) = shift f >>= (g . k)`
-- mapCont g (shift f) = Cont (g . evalCont . f)


-- Applications: delimited control with shift and reset

(-!),(+!),(*!) :: (Num a, Monad m) => m a -> m a -> m a
(-!) = liftM2 (-)
(+!) = liftM2 (+)
(*!) = liftM2 (*)

(++!) :: (Monad m) => m String -> m String -> m String
(++!) = liftM2 (++)

-- mapCont g (shift f) = Cont (g . evalCont . f)

t1 = shift (\k -> return "A") -- "A" with special cont processing
t2 = shift (\k -> return (k "A")) -- "A" with special cont processing
t3 = shift (\k -> return (k (k "A"))) -- "A" with special cont processing

t1a = return "B" ++! t1 -- "A" with special cont processing
t2a = return "B" ++! t2 -- "BA" with special cont processing
t3a = return "B" ++! t3 -- "BBA" with special cont processing

t1a' = return "C" ++! t1a -- "A"; equals to return "CB" ++! t1
t2a' = return "C" ++! t2a -- "CBA"; equals to return "CB" ++! t2
t3a' = return "C" ++! t3a -- "CBCBA"; equals to return "CB" ++! t3

t1b = reset t1a -- return "A"
t2b = reset t2a -- return "BA"
t3b = reset t3a -- return "BBA"

t1c = reset t1 -- return "A"
t2c = reset t2 -- return "A"
t3c = reset t3 -- return "A"

t1d = return "B" ++! t1c -- return "BA"
t2d = return "B" ++! t2c -- return "BA"
t3d = return "B" ++! t3c -- return "BA"

-- basic ignoring
-- replace ++"B" with (\k -> return "A") ++"B" == return "A"

t4 = return "C" ++! reset (return "B" ++! shift (\k -> return "A")) 
