-- The naive pattern matching algorithm
module Naive where

-- takes the string and pattern, 
-- returns a list of all indexes where the pattern matches
match :: (Eq a1, Num a2) => [a1] -> [a1] -> [a2]
match [] _ = []
match (h:t) pattern
    | matchAtHead (h:t) pattern = 0:[x+1 | x <- (match t pattern)]
    | otherwise = [x+1 | x <- (match t pattern)]
    -- check if pattern matches at index 0. if yes, add 0 to the return list
    -- call math again with the rest of the string
    -- increment every index in the next recursion result
 
-- Try: match "oh something something" "some"
 
 
matchAtHead :: (Eq a) => [a] -> [a] -> Bool
matchAtHead _ [] = True
matchAtHead [] _ = False
matchAtHead (h:t) (ph:pt) = (h == ph) && (matchAtHead t pt)
-- given the string (h:t) and pattern (ph:pt), 
-- if pattern matches string at index 0, return true
-- else return false
-- NOTE: if pattern is empty, defaults to TRUE. Change this if needed. 
-- NOTE2: case sensitive
 
 
-- Try: matchAtHead "something wicked" "some"
--      matchAtHead "something wicked" "wicked"
