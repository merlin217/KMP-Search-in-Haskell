# 312Project1: Pattern Matching in Haskell
*Author: Shijia Su, Tom Mo*

Implemented the Naive and Kmp pattern matching algorithm in haskell. 

To use in GHCI: 

```haskell
:load kmp.hs

match {text} {pattern}  -- naive
kmpMatch {text} {pattern} -- kmp algorithm
```

## Testing Runtime

We tested runtime in GHCI like this: 
```haskell
:set +s

match (take 10000 (cycle "xax")) "axxa"
> (7.72 secs, 4,647,571,728 bytes)

kmpMatch (take 10000 (cycle "xax")) "axxa"
> (6.15 secs, 3,718,333,688 bytes)

match (take 20000 (cycle "xax") "axxaxxaxxa")
> (36.56 secs, 18,784,034,520 bytes)

kmpMatch (take 20000 (cycle "xax") "axxaxxaxxa")
> (26.71 secs, 15,048,466,616 bytes)

```
The kmp algorithm is consistently faster and less memory-intensive than the naive method, and the longer the pattern is, the more obvious the difference, which is consistent with the advantage of kmp algorithm. 

Something to note is that our implementation updates every element of the entire return array in each recursion. This can be a source of inefficiency. 