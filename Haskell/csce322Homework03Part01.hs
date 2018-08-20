import Prelude
import System.Environment ( getArgs )
import Data.List
import Helpers

-- The main method that will be used for testing / comgand line access
main = do
     args <- getArgs
     filename <- readFile (head args)
     (hands,trains) <- readDominoesFile filename
     print "Result"
     printTrains [(onePlayerOneMove (head hands) (head trains))]

-- YOUR CODE SHOULD COME AFTER THIS POINT
onePlayerOneMove :: [(Int,Int)] -> [(Int,Int)] -> [(Int,Int)]
onePlayerOneMove hand train = addDomino hand (trainDomino train)

trainDomino:: [(Int, Int)] -> [(Int, Int)]
trainDomino [] = []
trainDomino [x] = [x]
trainDomino (h:hh:t)
             | ((dominoLastInt h) == (dominoFirstInt hh)) = [h] ++ (trainDomino (hh:t))

--Get last int of a single domino
dominoLastInt :: (Int, Int) -> Int
dominoLastInt (x , y) = y

--Get first int of a single domino
dominoFirstInt :: (Int, Int) -> Int
dominoFirstInt (x , y) = x

--Get last element of a list
listLast :: [a] -> a
listLast [x] = x
listLast (_:t) = listLast t

--Get first element of a list
listFirst :: [a] -> a
listFirst [x] = x
listFirst (h:_) = h

--Add Domino to front/back
addDomino :: [(Int, Int)] -> [(Int, Int)] -> [(Int, Int)]
addDomino [] b = b
addDomino (x:xs) b
          | (dominoLastInt x) == (dominoFirstInt (listFirst b)) = [x] ++ b
          | (dominoLastInt (swapDomino x)) == (dominoFirstInt (listFirst b)) = [swapDomino x] ++ b
          | (dominoLastInt (listLast b)) == (dominoFirstInt x) = b ++ [x]
          | (dominoLastInt (listLast b)) == (dominoFirstInt (swapDomino x)) = b ++ [swapDomino x]
          | otherwise = addDomino xs b

--Swap/Reverse Domino
swapDomino :: (Int, Int) -> (Int, Int)
swapDomino (x,y) = (y,x)
