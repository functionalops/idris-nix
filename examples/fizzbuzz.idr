||| Write a program that prints the numbers from 1 to 100.
||| For multiples of three print "fizz".
||| For multiples of five print "buzz".
||| For numbers which are multiple of three and five print "fizzbuzz".
module FizzBuzz

data Fizz : Type where
  MkFizz : Nat -> Fizz

data Buzz : Type where
  MkBuzz : Nat -> Buzz

data FizzBuzz : Type where
  MkFizzBuzz : Nat -> FizzBuzz

Pred : Type -> Type
Pred = \a => a -> Bool

PredOp : Type -> Type
PredOp = \a => (Pred a, Pred a) -> Pred a

isDivisibleBy : Nat -> Pred Nat
isDivisibleBy k = \x => (x `mod` k) == 0

isFizzBuzz : Pred Nat
isFizzBuzz = isDivisibleBy 15

isBuzz : Pred Nat
isBuzz = isDivisibleBy 5

isFuzz : Pred Nat
isFuzz = isDivisibleBy 3


