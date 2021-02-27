 
-- The KMP pattern matching algorithm
module Kmp where

import Naive
 
lpsArr :: Eq a => [a] -> [Int]
lpsArr str = [lpsAt str i| i <- [0..(length str - 1)]]
-- return an array of lps each corresponding to lps at that index
 
-- lpsAt
lpsAt :: Eq a => [a] -> Int -> Int
lpsAt str i = lps (Prelude.take (i+1) str)
-- return the length of the lps for sub-array 0..i
 
lps :: Eq a => [a] -> Int
lps str = lpsHelper str (length str - 1)
-- given str, return the longest proper prefix that is also a suffix for it
 
lpsHelper :: Eq a => [a] -> Int -> Int
lpsHelper str firstN
    | firstN == 0                     = firstN
    | isSuffix str (Prelude.take firstN str)  = firstN
    | otherwise                       = lpsHelper str (firstN-1)
-- str: the string we want to find lps for
-- firstN: first n characters
-- given a string and firstN, check if firstN characters of the string is its suffix
 
isSuffix :: (Eq a) => [a] -> [a] -> Bool
isSuffix str pattern = matchAtHead (reverse str) (reverse pattern)
-- Checks if pattern is a suffix of str
-- NOTE: matchAtHead is case sensitive
 
 
-- takes two array
-- return the index of the first different character start with index  
getLpsIndex [] _ val = 0
getLpsIndex _ [] val = 0
getLpsIndex (h:t) (ph:pt) val
    | h == ph = getLpsIndex t pt (val + 1)
    | otherwise = val
 
-- takes the string and pattern, 
-- returns a list of all indexes where the pattern matches by calling kmpMatchHelper
kmpMatch :: (Eq a1) => [a1] -> [a1] -> [Int]
kmpMatch [] _ = []
kmpMatch (h:t) pattern = kmpMatchHelper (h:t) pattern 0 (lpsArr pattern)


-- takes text, pattern, current value of lps that we want to look at and lps array
-- returns a list of all indexes where the pattern matches as our brute force way
kmpMatchHelper :: (Eq a1) => [a1] -> [a1] -> Int ->[Int] -> [Int]
kmpMatchHelper [] _ _ _= []
kmpMatchHelper txt pattern lpsVal lps
    | matchAtHead txt (drop lpsVal pattern) = 0-lpsVal:[x + dropOffset | x <- (kmpMatchHelper (drop (dropOffset) txt)  pattern (lps!!(length lps - 1)) lps )]
    | mismatchIdx == 0                      = [x+1 | x <- (kmpMatchHelper (drop 1 txt) pattern lpsVal lps)]
    | otherwise                             = [x+(mismatchIdx) | x <- (kmpMatchHelper (drop mismatchIdx txt) pattern (lps !! mismatchIdx) lps)]
    where mismatchIdx = getLpsIndex txt pattern 0
          dropOffset = lps!!(length lps - 1) - lpsVal + 1  
-- lps:         the lps array for pattern
-- lpsVal:      the pointer indicating which index of pattern we are searching at
-- dropOffset:  if txt's head matches with pattern[lpsVal..] we drop that portion of the original text in the recursive call
 
-- Try: kmpMatch "oh something something" "some"
-- Try: kmpMatch "XABXABXABXAB" "ABXAB"
-- Try: kmpMatch "ABABABAB" "AB"


