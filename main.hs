module Main where

import Naive
import Kmp
import System.TimeIt
import Control.Monad
import Control.Exception
import System.IO

main = do menu `catch` choiceErrorHandlder

menu = do
    let validInputs = ['0','1','2']
    putStrLn "\n-- Pattern Matching: Naive & KMP -- \nChoose one option: "
    putStrLn "\t1 - Enter text on console"
    putStrLn "\t2 - Enter text by file"
    putStrLn "\t0 - Exit"
    (choice:_) <- getLine

    case choice of
        '0' -> putStrLn "Program Ended! "
        '1' -> onConsole
        '2' -> byFile
        _  -> inputError


inputError = do
    putStrLn "Input error. Enter a valid input \n"
    main

{-
handles io error raised by the choice menu
-}
choiceErrorHandlder :: IOError -> IO ()
choiceErrorHandlder e = inputError

{-
    Getting content from console
-}
onConsole = do
    putStrLn "Enter text: "
    txt <- getLine
    promptPtn txt

{-
    Getting content from file
-}
byFile = do
    putStrLn "Enter file directory: "
    fileName <- getLine

    fileHandle <- openFile fileName ReadMode
    content <- hGetContents fileHandle
    
    promptPtn content
    hClose fileHandle


{-
    Given the text, prompt for patterns to search
-}
promptPtn txt = do
    putStrLn "Enter the pattern: "
    ptn <- getLine
    testTimes txt ptn

    putStrLn "\nSearch for another pattern? (y/n)"
    (choice:_) <- getLine
    case choice of
        'y' -> promptPtn txt
        'n' -> main
        _  -> inputError2 txt

inputError2 txt = do
    putStrLn "Input error. Enter a valid input \n"
    promptPtn txt

{-
    Find matches & print time taken
-}
testTimes txt ptn = do
    timeIt $ putStrLn ("Naive Result: " ++ show (match txt ptn))
    timeIt $ putStrLn ("KMP   Result: " ++ show (kmpMatch txt ptn))