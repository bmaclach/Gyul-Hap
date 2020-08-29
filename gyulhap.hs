import Data.List

import Board

main = do
  contents <- getContents
  let inputBoard :: Board
      inputBoard = map read $ filter (not . null) $ lines contents
      solutionHaps = findHaps inputBoard
  putStrLn $ serveOutputText solutionHaps

findHaps :: Board -> [Hap]
findHaps [] = error "Your input file is empty!"
findHaps [a] = error "Your input file has only one picture. You need at least three. Please update your input file."
findHaps [a, b] = error "Your input file has only two pictures. You need at least three. Please update your input file."
findHaps grid =
    let tileSet = splitTriads grid
        evals = map isHap tileSet
        trues = filter snd (zip tileSet evals)
        sol = [fst x | x <- trues]
    in sol

splitTriads :: Board -> [Hap]
splitTriads board = nub [Hap t1 t2 t3 | t1 <- board, t2 <- board, t3 <- board, t1 /= t2, t1 /= t3, t2 /= t3]

isHap :: Hap -> Bool
isHap (Hap t1 t2 t3) = let tiles = [t1, t2, t3] 
  in allSameOrDifferent colour tiles 
  && allSameOrDifferent shape tiles
  && allSameOrDifferent background tiles

allSameOrDifferent :: (Eq a) => (Tile -> a) -> [Tile] -> Bool
allSameOrDifferent f es = let numDistincts = length $ nub (map f es) 
    in numDistincts == 1 || numDistincts == length es

serveOutputText :: [Hap] -> String
serveOutputText [] = "\nThere are zero haps on this board!"
serveOutputText haps = intercalate "\n\n" $ "\nThe haps are:" : map show haps