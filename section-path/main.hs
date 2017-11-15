-- groups the given array into sub arrays of n elements each
groupsOf :: Int -> [a] -> [[a]]
groupsOf 0 _ = undefined 
groupsOf _ [] = []
groupsOf n xs = take n xs : groupsOf n (drop n xs)

-- parses each line in a string to int
parseIntegersByLine :: String -> [Int]
parseIntegersByLine = (map read) . lines

-- section and road definitions to store the problem
data Section = Section { getA :: Int, getB :: Int, getC :: Int } deriving (Show)
type RoadSystem = [Section]

-- Data types for defining the road choices, and storing the prices
data Label = A | B | C deriving (Show)
type Path = [(Label, Int)]
data PathWithPrice = PathWithPrice { getPrice :: Int, getPath :: Path }

-- a function that creates empty path with price
emptyPathWithPrice = PathWithPrice 0 []

-- stepper function for the foldl. Adds a section to the previous optimal solution.
-- first optimal solution is the empty path, then we start generating optimal solutions,
-- according to the new sections.
roadStep :: (PathWithPrice, PathWithPrice) -> Section -> (PathWithPrice, PathWithPrice)
roadStep (pwpA, pwpB) (Section a b c) =
  let 
      priceA = getPrice pwpA
      priceB = getPrice pwpB
      pathA = getPath pwpA
      pathB = getPath pwpB
      -- price to directly pass to the next section from A
      forwardPriceToA = priceA + a
      -- price to take a crossing from B to the next section.
      crossPriceToA = priceB + b + c
      -- price to directly pass to the next section from B
      forwardPriceToB = priceB + b
      -- price to take a crossing from A to the next section.
      crossPriceToB = priceA + a + c
      newPathToA = if forwardPriceToA <= crossPriceToA
                    then PathWithPrice forwardPriceToA $ (A, a) : pathA
                    else PathWithPrice crossPriceToA $ (C, c) : (B, b) : pathB
      newPathToB = if forwardPriceToB <= crossPriceToB
                    then PathWithPrice forwardPriceToB $ (B, b) : pathB
                    else PathWithPrice crossPriceToB $ (C, c) : (A, a) : pathA
  in (newPathToA, newPathToB) -- return new optimal solutions

-- given a road system, returns the optimal solution for it.
optimalPath :: RoadSystem -> PathWithPrice
optimalPath road =
  -- create an optimal solution from an empty optimal solution and a list of sections
  let (pwpA, pwpB) = foldl roadStep (emptyPathWithPrice, emptyPathWithPrice) road
      -- pick the best option, given the prices of the 2 different scenarios.
      optimal = if getPrice pwpA <= getPrice pwpB then pwpA else pwpB
  in
    -- reverse the solutions since we always use cons with the roadStep function
    -- its faster to reverse once, rather then always add to the end. (with lists anyways.)
    PathWithPrice (getPrice optimal) (reverse $ getPath optimal)

main = do
  input <- getContents
  let numbers = groupsOf 3 $ parseIntegersByLine input 
      sections = map (\[a, b, c] -> Section a b c) numbers
      optimal = optimalPath sections
      optimalPathStr = concat $ map (show .fst) $ getPath optimal
      optimalPrice = getPrice optimal
      
  putStrLn $ "Optimal path to take: " ++ optimalPathStr
  putStrLn $ "The price to take this path: " ++ (show optimalPrice)
