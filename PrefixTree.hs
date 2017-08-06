module PrefixTree
(
    PrefixNode, PrefixTree, nodeEq, getPTChar, getPTChildren, addString,
    getAllStrings, countAllStrings, find, countWithPrefix
) where

-- a simple library for storing strings with fast(ish) prefix checking for searches
-- uses PrefixLeaf to denote the end of a stored string
-- author: Reid Swan (reidswan [at] outlook.com)
-- date: 2017/08/07

data PrefixNode = Node Char [PrefixNode] | PrefixLeaf deriving Show
type PrefixTree = [PrefixNode]

instance Eq PrefixNode where
    (==) = nodeEq

nodeEq :: PrefixNode -> PrefixNode -> Bool
-- determine if two prefix nodes are equal based on their contained Chars
nodeEq PrefixLeaf PrefixLeaf = True
nodeEq PrefixLeaf _          = False
nodeEq _ PrefixLeaf          = False
nodeEq (Node c e) (Node d f) = c == d

getPTChar :: PrefixNode -> Char
-- get the Char held in a node
getPTChar PrefixLeaf = '.'
getPTChar (Node c _) = c

getPTChildren :: PrefixNode -> [PrefixNode]
-- get the children of a node
getPTChildren PrefixLeaf = []
getPTChildren (Node _ c) = c

addString :: PrefixTree -> String -> PrefixTree
-- add a string to an existing PrefixTree
addString [] (s:ss) = [Node s (addString [] ss)]
addString ts []     = if PrefixLeaf `elem` ts then ts else PrefixLeaf:ts
addString (Node chr children:ts) (s:ss)
    | chr == s = Node chr (addString children ss):ts
    | otherwise = Node chr children:addString ts (s:ss)
addString (PrefixLeaf:ts) ss = PrefixLeaf:addString ts ss

getAllStrings :: PrefixTree -> [String]
-- returns all the Strings stored in the given PrefixTree
getAllStrings [] = []
getAllStrings (PrefixLeaf:ts) = "":getAllStrings ts
getAllStrings (Node chr children:ts) = map ((:) chr)  (getAllStrings children) ++ getAllStrings ts

countAllStrings :: PrefixTree -> Int
-- counts the number of Strings stored in the given PrefixTree
countAllStrings [] = 0
countAllStrings (PrefixLeaf:ts) = 1 + countAllStrings ts
countAllStrings (Node chr children:ts) =  countAllStrings children + countAllStrings ts

find :: PrefixTree -> String -> [String]
-- returns a set of Strings from the PrefixTree which have the given prefix
find tree prefix = map (prefix ++) $ find' tree prefix where
    find' [] _ = []
    find' ts [] = getAllStrings ts
    find' (Node chr children:ts) (s:ss)
        | chr == s = find' children ss
        | otherwise = find' ts (s:ss)
    find' (PrefixLeaf:ts) ss = find' ts ss

countWithPrefix :: PrefixTree -> String -> Int
-- counts the Strings stored in the PrefixTree which have the given prefix
countWithPrefix [] _ = 0
countWithPrefix ts [] = countAllStrings ts
countWithPrefix (Node chr children:ts) (s:ss)
    | chr == s = countWithPrefix children ss
    | otherwise = countWithPrefix ts (s:ss)
countWithPrefix (PrefixLeaf:ts) ss = countWithPrefix ts ss
