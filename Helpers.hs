module Helpers where

import Board

fstTile :: Hap -> Tile
fstTile (t1, t2, t3) = t1

sndTile :: Hap -> Tile
sndTile (t1, t2, t3) = t2

thirdTile :: Hap -> Tile
thirdTile (t1, t2, t3) = t3

listToTuple :: [a] -> (a, a, a)
listToTuple [p1, p2, p3] = (p1, p2, p3)

readTuple :: (Read a, Read b, Read c) => (String, String, String) -> (a, b, c)
readTuple (colour, shape, background) = (read colour, read shape, read background)

showTuple :: (Show a, Show b, Show c) => (a, b, c) -> String
showTuple (colour, shape, background) = show colour ++ " " ++ show shape ++ " " ++ show background

mapThreeTuple :: (a -> b) -> (a, a, a) -> [b]
mapThreeTuple f (tile1, tile2, tile3) = [f tile1, f tile2, f tile3]

removeDups :: [Hap] -> [Hap]
removeDups [] = []
removeDups (h:xs)
    | (x,z,y) `elem` xs = removeDups xs
    | (y,x,z) `elem` xs = removeDups xs
    | (y,z,x) `elem` xs = removeDups xs
    | (z,x,y) `elem` xs = removeDups xs
    | (z,y,x) `elem` xs = removeDups xs
    | otherwise         = h:removeDups xs
    where x = fstTile h
          y = sndTile h
          z = thirdTile h