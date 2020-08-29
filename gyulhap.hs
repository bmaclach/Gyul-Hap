import Data.List

import Board
import Helpers

main = do
    contents <- getContents
    let inputBoard = map readTuple $ map listToTuple $ (map . map) decodeShortForm $ map words $ filter (not . null) $ lines contents
        solutionHaps = intercalate "\n\n" $ map (intercalate ", ") $ map (mapThreeTuple showTuple) $ findHaps inputBoard
    putStrLn $ serveOutputText solutionHaps

validInput :: [String]
validInput = ["Red", "Blue", "Yellow", "Purple", "Green", "Orange", "Circle", "Square", "Triangle", "Sun", "Moon", "Star", "Black", "Grey", "White"]

findHaps :: Board -> [Hap]
findHaps [] = error "Your input file is empty!"
findHaps [a] = error "Your input file has only one picture. You need at least three. Please update your input file."
findHaps [a, b] = error "Your input file has only two pictures. You need at least three. Please update your input file."
findHaps grid =
    let tileSet = splitTriads grid
        evals = map evalHap tileSet
        trues = filter snd (zip tileSet evals)
        sol = [fst x | x <- trues]
    in sol

splitTriads :: Board -> [Hap]
splitTriads board = removeDups [(t1, t2, t3) | t1 <- board, t2 <- board, t3 <- board, t1 /= t2, t1 /= t3, t2 /= t3]

evalHap :: Hap -> Bool
evalHap hap
    | propertyCondition getColour hap && propertyCondition getShape hap && propertyCondition getBackground hap = True
    | otherwise = False

propertyCondition :: (Eq a) => (Tile -> a) -> Hap -> Bool
propertyCondition f hap
    | x == y, y == z, x == z = True
    | x /= y, y /= z, x /= z = True
    | otherwise              = False
    where (x,y,z) = mapHap f hap

decodeShortForm :: String -> String
decodeShortForm a
    | isInfixOf [a] validInput = a
    | a == "R" = "Red"
    | a == "B" = "Blue"
    | a == "Y" = "Yellow"
    | a == "P" = "Purple"
    | a == "G" = "Green"
    | a == "O" = "Orange"
    | a == "C" = "Circle"
    | a == "Sq" = "Square"
    | a == "T" = "Triangle"
    | a == "S" = "Sun"
    | a == "M" = "Moon"
    | a == "St" = "Star"
    | a == "Bk" = "Black"
    | a == "Gy" = "Grey"
    | a == "W" = "White"
    | otherwise = error "There's something in your input file that I can't read! Please double-check the formatting and try again."

serveOutputText :: String -> String
serveOutputText "" = "\nThere are zero haps on this board!"
serveOutputText (haps) = "\nThe haps are:\n\n" ++ haps