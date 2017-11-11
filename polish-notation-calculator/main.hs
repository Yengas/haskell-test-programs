import Data.List
import Data.Maybe

main = interact evaluateExpression 

evaluateExpression :: String -> String
evaluateExpression input = unlines . map (\line -> case solveRPN line of Nothing -> "Invalid expression."; Just a -> "Result: " ++ show a) $ lines input

add (x:y:_) = Just $ x + y
add _ = Nothing

sub (x:y:_) = Just $ x - y
sub _ = Nothing

mult (x:y:_) = Just $ x * y
mult _ = Nothing

arithmeticOperations :: (Num a) => [(String, (Int, [a] -> Maybe a))]
arithmeticOperations = [("+", (2, add)), ("-", (2, sub)), ("*", (2, mult)), ("sum", (maxBound, Just . sum))]

foldFunction :: (Num a, Read a, Show a) => Maybe [a] -> String -> Maybe [a]
foldFunction xs str
  | null xs = xs -- if the result is none
  -- if the operation is found with the lookup, run the found func
  | not $ null opLookup =
    let (count, func) = fromJust opLookup in
      case xs of
        Nothing -> Nothing
        Just list -> let (args, rest) = splitAt count list in fmap (:rest) (func args)
  -- otherwise try the other functions.
  | otherwise = restFunction xs str
  where opLookup = lookup str arithmeticOperations
        -- restFunction (Just (x:y:xs)) "^" = Just $ (x ** y) : xs
        -- if none other function matched, try to read the str as an `a` and add it to the start of the list.
        restFunction (Just xs) str = fmap (\(x,_) -> x : xs) $ listToMaybe $ reads str

solveRPN :: (Num a, Read a, Show a) => String -> Maybe a
solveRPN input = fmap head $ foldl foldFunction (Just []) $ words input
