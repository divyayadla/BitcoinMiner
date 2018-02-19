# Description

Bitcoins (see http://en.wikipedia.org/wiki/Bitcoin) are the most popular crypto-currency in common use. At their heart, bitcoins use the hardness of cryptographic hashing (for a reference see http://en.wikipedia.org/wiki/Cryptographic hash function) to ensure a limited “supply” of coins. In particular, the key component in a bitcoin is an input that, when “hashed” produces an output smaller than a target value. In practice, the comparison values have leading 0’s, thus the bitcoin is required to have a given number of leading 0’s (to ensure 3 leading 0’s, you look for hashes smaller than 0x001000... or smaller or equal to 0x000ff.... 

The hash you are required to use is SHA-256. You can check your version against this online hasher: http://www.xorbin.com/tools/sha256-hash-calculator. 

For example, when the text “COP5615 is a boring class” is hashed, the value 0xe9a425077e7b492076b5f32f58d5eb6824b1875621e6237f1a2430c6b77e467c is obtained. 

For the coins you find, check your answer with this calculator to ensure correctness. The goal of this first project is to use Elixir and the actor model to build a good solution to this problem that runs well on multi-core machines.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `project1` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:project1, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/project1](https://hexdocs.pm/project1).

## Running Instructions

Take a look at the project report for further instructions on how to setup the project and implement it.
