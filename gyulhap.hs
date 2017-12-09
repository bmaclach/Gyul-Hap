import Data.List

data Colour = Red | Blue | Yellow | Purple | Green | Orange deriving (Show, Eq, Read)

data Shape = Circle | Square | Triangle | Sun | Moon | Star deriving (Show, Eq, Read)

data Background = Black | Grey | White deriving (Show, Eq, Read)

type Tile = (Colour, Shape, Background)

type Board = [Tile]

type Hap = (Tile, Tile, Tile)

main = do
    contents <- getContents
    let inputBoard = map readTuple $ map decodeBackground $ map decodeShape $ map decodeColour $ map listToTuple $ map words $ lines contents
        solutionHaps = intercalate "\n\n" $ map (intercalate ", ") $ map (mapThreeTuple showTuple) $ findHaps inputBoard
    putStrLn $ "The haps are:\n\n" ++ solutionHaps

trialBoard :: Board
trialBoard = [(Yellow, Triangle, White), (Blue, Square, White), (Yellow, Circle, Grey), (Blue, Triangle, Black), (Red, Circle, White), (Yellow, Square, White), (Yellow, Triangle, Grey), (Blue, Circle, Black), (Red, Square, Black)]

findHaps :: Board -> [Hap]
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

fstTile :: Hap -> Tile
fstTile (t1, t2, t3) = t1

sndTile :: Hap -> Tile
sndTile (t1, t2, t3) = t2

thirdTile :: Hap -> Tile
thirdTile (t1, t2, t3) = t3

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

listToTuple :: [a] -> (a, a, a)
listToTuple [p1, p2, p3] = (p1, p2, p3)

readTuple :: (Read a, Read b, Read c) => (String, String, String) -> (a, b, c)
readTuple (colour, shape, background) = (read colour, read shape, read background)

showTuple :: (Show a, Show b, Show c) => (a, b, c) -> String
showTuple (colour, shape, background) = show colour ++ " " ++ show shape ++ " " ++ show background

mapThreeTuple :: (a -> b) -> (a, a, a) -> [b]
mapThreeTuple f (tile1, tile2, tile3) = [f tile1, f tile2, f tile3]

decodeColour :: (String, String, String) -> (String, String, String)
decodeColour (c, s, b)
    | c == "Red", c == "Blue", c == "Yellow", c == "Purple", c == "Green", c == "Orange" = (c, s, b)
    | c == "R" = (c ++ "ed", s, b)
    | c == "B" = (c ++ "lue", s, b)
    | c == "Y" = (c ++ "ellow", s, b)
    | c == "P" = (c ++ "urple", s, b)
    | c == "G" = (c ++ "reen", s, b)
    | c == "O" = (c ++ "range", s, b)

decodeShape :: (String, String, String) -> (String, String, String)
decodeShape (c, s, b)
	| s == "Circle", s == "Square", s == "Triangle", s == "Sun", s == "Moon", s == "Star" = (c, s, b)
	| s == "C" = (c, s ++ "ircle", b)
	| s == "Sq" = (c, s ++ "uare", b)
	| s == "T" = (c, s ++ "riangle", b)
	| s == "S" = (c, s ++ "un", b)
	| s == "M" = (c, s ++ "oon", b)
	| s == "St" = (c, s ++ "ar", b)
	
decodeBackground :: (String, String, String) -> (String, String, String)
decodeBackground (c, s, b)
	| b == "Red", b == "Blue", b == "Yellow", b == "Purple", b == "Green", b == "Orange" = (c, s, b)
	| b == "B" = (c, s, b ++ "lack")
	| b == "G" = (c, s, b ++ "rey")
	| b == "W" = (c, s, b ++ "hite")