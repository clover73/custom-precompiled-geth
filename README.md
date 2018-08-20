# Introduction
This is a workshop example to explain how to implement a new precompiled contract.
A precompiled contract is an implemented class within an ethereum node, that is pinned to a fixed contract address.

# Objective
Implementing a custom feature as a precompiled contract allows new functionality to be added to mining nodes without making changes to the EVM opcode, making it a much cleaner way to implement complex new feature. Some possible use of this is for adding new cryptographic functions, complex zero knowledge proof verifier, external call to oracles or another chain, etc.

Typically on the base chain, such changes will need to be implemented across all ethereum node implementations and also rquires a hardfork by the miners for adoption. Thus, they need to undergo the lengthy EIP process before mass adoption.

However, when used in building private networks of ethereum nodes, or as a layer-2 plasma chain, it can be very useful to easily add custom functionality to the private chain.

# Basic principles
- Define a new class for the feature, that implements the interface `PrecompiledContract`. Make the necessary changes in `core/vm/contracts.go`
- Add the address of the class to the precompiled contract mapping, also in `core/vm/contracts.go`
- Create a corresponding function in the smart contract which calls the precompiled contract using the an assembly `call()` method, with the predefined address.
```
call(g, a, v, in, insize, out, outsize)
```
call contract at address a with input `mem[in..(in+insize))` providing `g` gas and ether value `v` wei and output area `mem[out..(out+outsize))` returning `0` on error (eg. out of gas) and `1` on success

# Usage
This repo defines a simple `helloPrecompiled` precompiled contract which prints out a hello world message on the console of the ethereum node.

Refer to [go-ethereum's original README](GETH.md) on instructions to build the `geth` client.

Start a private instance of the `geth`. You can follow this very useful [tutorial](https://souptacular.gitbooks.io/ethereum-tutorials-and-tips-by-hudson/content/private-chain.html) reference.

The `demo` folder contains a simple truffle project with a contract to call the `helloPrecompiled` precompiled contact. `migrate` this project to deploy the contract and call the `callPrecompiled` function. 