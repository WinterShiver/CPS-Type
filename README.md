# CPS-Type

Continuation-Passing-Style in Haskell and some exploration of it.

## Continuation Monad

Cont.hs

* The definition of Continuation Monad
* Proof of Functor/Applicative/Monad properties
* Superset of Identity Monad [TODO]

ContUtils.hs

* Useful functions related to Cont Monad

## Control with Cont Monad

### Undelimited Continuations [TODO]

CallCC.hs

* Undelimited continuations
  * Definition of call/cc
  * Control with call/cc: capture the rest part with computation
* Supporting materials
  * [Undelimited continuations are not functions](https://okmij.org/ftp/continuations/undelimited.html)

### Delimited Control [Work in progress]

Delimited.hs

* Delimited control
  * Definition of shift and reset
  * Properties of shift and reset
  * Delimited control with shift and reset
* Supporting materials
  * [Introduction to programming with shift and reset](https://okmij.org/ftp/continuations/#tutorial)

## Algebraic Data Types with Continuation-Passing-Style

### ADTs and Isomorphisms

ADT.hs

* Some isomorphisms between common types (listed below) and ADTs

  * Type constructed by data constructors
  * Parameterized types
  * Types with record syntax
  * GADTs and recursive data types
* Read more about ADTs and Isomorphisms - [References](./ADT.md)

### ADT Monads [TODO]

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
