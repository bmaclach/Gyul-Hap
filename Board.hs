module Board where

data Colour = Red | Blue | Yellow | Purple | Green | Orange deriving (Show, Eq, Read)

data Shape = Circle | Square | Triangle | Sun | Moon | Star deriving (Show, Eq, Read)

data Background = Black | Grey | White deriving (Show, Eq, Read)

type Tile = (Colour, Shape, Background)

type Board = [Tile]

type Hap = (Tile, Tile, Tile)

trialBoard :: Board
trialBoard = [
  (Yellow, Triangle, White), 
  (Blue, Square, White), 
  (Yellow, Circle, Grey), 
  (Blue, Triangle, Black), 
  (Red, Circle, White), 
  (Yellow, Square, White), 
  (Yellow, Triangle, Grey), 
  (Blue, Circle, Black), 
  (Red, Square, Black)]

makeHap :: Tile -> Tile -> Tile -> Hap
makeHap tile1 tile2 tile3 = (tile1, tile2, tile3)

mapHap :: (Tile -> a) -> Hap -> (a, a, a)
mapHap f (t1, t2, t3) = (f t1, f t2, f t3)

getColour :: Tile -> Colour
getColour (c,s,b) = c

getShape :: Tile -> Shape
getShape (c,s,b) = s

getBackground :: Tile -> Background
getBackground (c,s,b) = b