main = do
  userInputMatrix <- askForMatrix 3 3
  -- get the square of each elem in the matrix and print
  print $ map (map (^2)) userInputMatrix

-- Creates a matrix with each element having its value as the row and column index for itself
-- createMatrix row column = map (\row -> map (\column -> (row, column)) [1..column]) [1..row]
createMatrix row column = [[(r, c) | c <- [1..column]] | r <- [1..row]]

-- asks for a single point in the matrix from the user
-- tries to read the input an integer
askFor row column = do
  putStr $ "Input(" ++ (show row) ++ "," ++ (show column) ++ "): "
  line <- getLine
  return $ (read line :: Int)

-- Ask a matrix from the user wwith the given dimensions
askForMatrix row column = do
  let matrix = createMatrix row column
  -- sequence $ map (sequence . map (\(r, c) -> askFor r c)) matrix
  mapM (mapM (\(r, c) -> askFor r c)) matrix

-- read in single line, as a string.
-- askForMatrix row column = sequence $ [sequence $ map (\c -> do putStr $ "Enter (" ++ (show r) ++ "," ++ (show c) ++ "): "; getLine) [1..column] | r <- [1..row]]
