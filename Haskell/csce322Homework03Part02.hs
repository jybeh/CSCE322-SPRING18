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
     printTrains [(onePlayerManyMoves (head hands) (head trains))]

-- YOUR CODE SHOULD COME AFTER THIS POINT
onePlayerManyMoves :: [(Int,Int)] -> [(Int,Int)] -> [(Int,Int)]
onePlayerManyMoves hand train = addDomino hand hand (trainDomino train)

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
addDomino :: [(Int, Int)] -> [(Int, Int)] -> [(Int, Int)] -> [(Int, Int)]
addDomino hand [] b = b
addDomino hand (h:t) train
          | (dominoLastInt h) == (dominoFirstInt (listFirst train)) = addDomino (removeDomino h hand) (removeDomino h hand) ([h] ++ train)
          | (dominoLastInt (swapDomino h)) == (dominoFirstInt (listFirst train)) = addDomino (removeDomino h hand) (removeDomino h hand) ([swapDomino h] ++ train)
          | (dominoLastInt (listLast train)) == (dominoFirstInt h) = addDomino (removeDomino h hand) (removeDomino h hand) (train ++ [h])
          | (dominoLastInt (listLast train)) == (dominoFirstInt (swapDomino h)) = addDomino (removeDomino h hand) (removeDomino h hand) (train ++ [swapDomino h])
          | otherwise = addDomino hand t train

--Swap/Reverse Domino
swapDomino :: (Int, Int) -> (Int, Int)
swapDomino (x,y) = (y,x)

--Remove domino from hand
removeDomino :: (Int, Int) -> [(Int, Int)] -> [(Int, Int)]
removeDomino _ [] = []
removeDomino x (y:ys)
               | x == y    = removeDomino x ys
               | otherwise = y : removeDomino x ys
