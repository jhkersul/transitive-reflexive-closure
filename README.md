# Transitive Recursive Closure

This is a Transitive-Reflexive Closure implementation. This algorithm uses a binary relation (R) that is contained inside a AxA.

Such algorithm was studied on PCS3556 - Computational Logics at Poli-USP.

Developed using Elixir programming language.

## Example of a scenario

Given a set A = {a, b, c}, we have a binary relation R = {(a, b), (b, c)}.

First, the algorithm will find all the (x, x) relations (Reflexive). So we will have:

R union {(a, a), (b, b), (c, c)}

Then, the algorithm will find the transitive closures, using a graph.

We have (a, b) and (b, c). So, the transitive closure will add (a, c).

## Running tests

All tests are available at `test/transitive_reflexive_closure_test.exs`

```bash
mix test
```
