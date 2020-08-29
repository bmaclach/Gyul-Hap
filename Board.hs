module Board where

import Data.List (intercalate)
import qualified Data.Set as Set (fromList)

data Colour = Red | Blue | Yellow | Purple | Green | Orange deriving (Show, Eq, Read, Ord)

readColour :: String -> Colour
readColour "R" = Red
readColour "B" = Blue
readColour "Y" = Yellow
readColour "P" = Purple
readColour "G" = Green
readColour "O" = Orange
readColour c = read c

data Shape = Circle | Square | Triangle | Sun | Moon | Star deriving (Show, Eq, Read, Ord)

readShape :: String -> Shape
readShape "C" = Circle
readShape "Sq" = Square
readShape "T" = Triangle
readShape "S" = Sun
readShape "M" = Moon
readShape "St" = Star
readShape s = read s

data Background = Black | Grey | White deriving (Show, Eq, Read, Ord)

readBackground :: String -> Background
readBackground "B" = Black
readBackground "Bk" = Black
readBackground "G" = Grey
readBackground "Gy" = Grey
readBackground "W" = White
readBackground bg = read bg

data Tile = Tile {
  colour :: Colour, 
  shape :: Shape,
  background :: Background} deriving (Eq, Ord)

instance Show Tile where
  show (Tile c s b) = show c ++ " " ++ show s ++ " " ++ show b

instance Read Tile where
  readsPrec _ str = readTile $ words str
    where readTile (c:s:b:rest) = [(Tile (readColour c) (readShape s) (readBackground b), unwords rest)]
          readTile _ = error $ "Each tile in the input file should be on a " ++
            "new line and described by the colour, shape, and background, " ++
            "separated by spaces"

type Board = [Tile]

data Hap = Hap Tile Tile Tile

instance Show Hap where
  show (Hap t1 t2 t3) = intercalate ", " $ map show [t1, t2, t3]

instance Eq Hap where
  (Hap t11 t12 t13) == (Hap t21 t22 t23) = 
    Set.fromList [t11, t12, t13] == Set.fromList [t21, t22, t23]
