# CPS-Type

CPS type in Haskell and some exploration of it.

## Continuation Monad

Cont.hs

* The definition of Continuation Monad
* Proof of Functor/Applicative/Monad properties
* Superset of Identity Monad [TODO]

## Algebraic Data Types and Isomorphisms

ADT.hs

* Some isomorphisms between common types (listed below) and ADTs

  * Type constructed by data constructors
  * Parameterized types
  * Types with record syntax
  * GADTs and recursive data types
* Read more about ADTs and Isomorphisms

  * [Isomorphism](https://www.codewars.com/kata/5922543bf9c15705d0000020)
  * [Algebraic Isomorphism](https://www.codewars.com/kata/algebraic-isomorphism)
  * [Exploding a Finite Algebraic Type](https://www.codewars.com/kata/5d4d9488a3d80c00158b54b8)

## ADT Monads [TODO]

SumType.hs

* The definition of continuation-passing-style sum type (`Sum`)
* `Sum` Monad
* Superset of Either Monad

ProdType.hs

* The definition of continuation-passing-style product type (`Prod`)
* `Prod` Monad
* Superset of (,) Monad

ContADTs.hs

* Take Maybe as example, define the continuation-passing-style ADT type (`ContMaybe`)
* `ContMaybe` Monad
* Superset of Maybe Monad
