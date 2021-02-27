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
> ((6.15 secs, 3,718,333,688 bytes))
```
