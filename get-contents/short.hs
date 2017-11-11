main = do
  contents <- getContents
  putStr $ shortLines contents

shortLines :: String -> String
shortLines input =
  let allLines = lines input
      shortLines = filter (\line -> (length line) <10) allLines
      result = unlines shortLines
  in  result

-- as an alternative, one liner
-- main = interact $ unlines . filter ((<10) . length) . lines  
