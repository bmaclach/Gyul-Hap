import Data.List (nub, intercalate)
import Data.Maybe (mapMaybe)

import Board

main = do
  contents <- getContents
  let inputBoard :: Board
      inputBoard = map read $ filter (not . null) $ lines contents
      solutionHaps = findHaps inputBoard
  putStrLn $ serveOutputText solutionHaps

findHaps :: Board -> [Hap]
findHaps [] = []
findHaps [_] = []
findHaps (a:xs) = findHaps' a xs ++ findHaps xs
  where findHaps' :: Tile -> Board -> [Hap]
        findHaps' _ [] = []
        findHaps' t (b:xs) = mapMaybe (makeHap t b) xs ++ findHaps' t xs

makeHap :: Tile -> Tile -> Tile -> Maybe Hap
makeHap t1 t2 t3 = let tiles = [t1, t2, t3]
  in if isHap tiles then Just $ Hap t1 t2 t3 
                    else Nothing

isHap :: [Tile] -> Bool
isHap tiles = allSameOrDifferent colour tiles 
           && allSameOrDifferent shape tiles
           && allSameOrDifferent background tiles

allSameOrDifferent :: (Eq a) => (Tile -> a) -> [Tile] -> Bool
allSameOrDifferent f es = let numDistincts = length $ nub (map f es) 
    in numDistincts == 1 || numDistincts == length es

serveOutputText :: [Hap] -> String
serveOutputText [] = "\nThere are zero haps on this board!"
serveOutputText haps = intercalate "\n\n" $ "\nThe haps are:" : map show haps