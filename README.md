# PrefixTree
Haskell implementation of a simple data structure and related methods for storing strings and searching prefixes of stored strings

## What it does
A PrefixTree stores a single character in each node, with child nodes representing the subsequent character in a stored string. The end of a stored string is indicated by a PrefixLeaf. Traversing the tree in order to a PrefixLeaf returns a stored string. 
Searching the tree for strings with a given prefix only requires traversing the tree following the characters of the prefix. At the end of the prefix string, all branches with the current node as ancestor are strings with the given prefix. 

## Example
See the ContactKeeper.hs file, which implements a simple (and non-persistent) contact storing and searching program using the PrefixTree library. 

## Why
To explore Haskell and become more familiar with it. 
